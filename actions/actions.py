from typing import Any, Text, Dict, List
from rasa_sdk import Action, Tracker
from rasa_sdk.executor import CollectingDispatcher
from rasa_sdk.events import SlotSet
import mysql.connector

# --- Configuración de la Base de Datos ---
DB_CONFIG = {
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': 'vinai_db_normalizada'
}

SABOR_KEYWORDS = ['vainilla', 'chocolate', 'pimienta', 'manzana', 'cereza', 'guinda', 'ciruela', 'cedro', 'tabaco', 'eucalipto', 'cítrico', 'melocotón', 'frutilla', 'arándano', 'miel', 'durazno', 'hierba', 'café', 'frambuesa']

def _get_db_connection():
    return mysql.connector.connect(**DB_CONFIG)

# --- 1. ACCIÓN PARA RECOMENDAR VINO (ACTUALIZADA CON BÚSQUEDA POR AÑO) ---
class ActionRecomendarVinoDb(Action):
    def name(self) -> Text: 
        return "action_recomendar_vino_db"

    def run(self, dispatcher: CollectingDispatcher, tracker: Tracker, domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
        # 1. Obtener todos los slots
        cepa = tracker.get_slot("slot_cepa")
        tipo = tracker.get_slot("slot_tipo_vino")
        valle = tracker.get_slot("slot_valle")
        caracteristica = tracker.get_slot("slot_caracteristica")
        maridaje = tracker.get_slot("slot_maridaje")
        ano = tracker.get_slot("slot_ano")
        
        latest_message = tracker.latest_message.get('text', '').lower()
        nota_sabor = next((s for s in SABOR_KEYWORDS if s in latest_message), None)
        
        if not any([cepa, tipo, valle, caracteristica, maridaje, nota_sabor, ano]):
            dispatcher.utter_message(response="utter_pedir_gusto")
            return []

        conn = None
        try:
            conn = _get_db_connection()
            cursor = conn.cursor()
            
            # 2. Construcción de la Consulta SQL Dinámica
            query = """
                SELECT DISTINCT v.id, v.nombre, v.cepa, v.ano, v.tipo, va.nombre, va.valle, v.link_compra 
                FROM vinos v 
                JOIN vinas va ON v.vina_id = va.id 
            """
            valores = []

            # JOINs Condicionales
            if nota_sabor:
                query += " JOIN vino_nota vn ON v.id = vn.vino_id JOIN notas_sabor ns ON vn.nota_id = ns.id"
            if caracteristica:
                query += " JOIN vino_caracteristica vc ON v.id = vc.vino_id JOIN caracteristicas c ON vc.caracteristica_id = c.id"
            if maridaje:
                query += " JOIN vino_maridaje vm ON v.id = vm.vino_id JOIN maridajes m ON vm.maridaje_id = m.id"

            # Cláusula WHERE y Condiciones
            query += " WHERE 1=1" 

            if cepa:
                query += " AND v.cepa = %s"
                valores.append(cepa.capitalize())
            if tipo:
                query += " AND v.tipo = %s"
                valores.append(tipo.capitalize())
            if valle:
                query += " AND va.valle LIKE %s"
                valores.append(f"%{valle}%")
            if nota_sabor:
                query += " AND ns.nombre = %s"
                valores.append(nota_sabor.capitalize())
            if caracteristica:
                query += " AND c.nombre = %s"
                valores.append(caracteristica.capitalize())
            if maridaje:
                query += " AND m.nombre = %s"
                valores.append(maridaje.capitalize())
            if ano:
                query += " AND v.ano = %s"
                valores.append(ano)
            
            query += " ORDER BY RAND() LIMIT 1;"
            
            cursor.execute(query, tuple(valores))
            resultado = cursor.fetchone()
            
            # 3. Formato de la Respuesta
            if resultado:
                vino_id, vino_nombre, cepa, ano, tipo, vina_nombre, valle_nombre, link = resultado
                
                notas_query = "SELECT ns.nombre FROM notas_sabor ns JOIN vino_nota vn ON ns.id = vn.nota_id WHERE vn.vino_id = %s"
                cursor.execute(notas_query, (vino_id,))
                notas_list = [n[0] for n in cursor.fetchall()]
                notas_str = ", ".join(notas_list)

                maridaje_query = "SELECT m.nombre FROM maridajes m JOIN vino_maridaje vm ON m.id = vm.maridaje_id WHERE vm.vino_id = %s"
                cursor.execute(maridaje_query, (vino_id,))
                maridaje_list = [m[0] for m in cursor.fetchall()]
                maridaje_str = ", ".join(maridaje_list)
                
                respuesta_texto = f"¡Perfecto! Te recomiendo el vino **{vino_nombre}** ({cepa} {tipo}) del año **{ano}**, de Viña {vina_nombre} ({valle_nombre})."
                if notas_str:
                    respuesta_texto += f" Notas de sabor que podrías encontrar: {notas_str}."
                if maridaje_str:
                    respuesta_texto += f" Maridaje sugerido: {maridaje_str}."
                
                custom_payload = {"link": link, "link_text": f"Comprar {vino_nombre}"}
                dispatcher.utter_message(text=respuesta_texto, json_message=custom_payload)
            else:
                dispatcher.utter_message(text="Lo siento, no encontré un vino que cumpla con *todos* esos criterios tan específicos. Prueba con menos restricciones.")

        except mysql.connector.Error as err:
            print(f"Error de base de datos en ActionRecomendarVinoDb: {err}")
            dispatcher.utter_message(text="Tuvimos un problema al buscar en nuestra bodega virtual. ¿Podrías intentarlo de nuevo?")
        finally:
            if conn:
                conn.close()
        
        slots_to_reset = ["slot_cepa", "slot_tipo_vino", "slot_valle", "slot_caracteristica", "slot_maridaje", "slot_ano"]
        return [SlotSet(slot, None) for slot in slots_to_reset]

# --- 2. ACCIÓN PARA BUSCAR TOUR POR VIÑA ---
class ActionBuscarTour(Action):
    def name(self) -> Text: 
        return "action_buscar_tour"

    def run(self, dispatcher: CollectingDispatcher, tracker: Tracker, domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
        vina_solicitada = tracker.get_slot("slot_vina")
        
        if not vina_solicitada:
            dispatcher.utter_message(text="¿Qué viña específica te gustaría visitar para un tour?")
            return [] 

        conn = None
        try:
            conn = _get_db_connection()
            cursor = conn.cursor()
            
            query = "SELECT nombre, descripcion_tour, horario_tour, link_web FROM vinas WHERE nombre LIKE %s AND descripcion_tour IS NOT NULL LIMIT 1;"
            cursor.execute(query, (f"%{vina_solicitada}%",))
            resultado = cursor.fetchone()
            
            cursor.close()

            if resultado:
                nombre_vina, desc_tour, horario, link = resultado
                respuesta_texto = f"¡Encontré información sobre el tour en **{nombre_vina}**! Detalles: {desc_tour}. Horario: {horario}. Puedes encontrar más detalles en su sitio web."
                custom_payload = {"link": link, "link_text": f"Web de {nombre_vina}"}
                dispatcher.utter_message(text=respuesta_texto, json_message=custom_payload)
            else:
                dispatcher.utter_message(text=f"Lo siento, no encontré tours disponibles para la viña '{vina_solicitada}' o no tenemos información al respecto.")
                
        except mysql.connector.Error as err:
            print(f"Error de base de datos en ActionBuscarTour: {err}")
            dispatcher.utter_message(text="Tuvimos un problema al consultar la base de datos de tours. Por favor, inténtalo más tarde.")
        finally:
            if conn:
                conn.close()
            
        # --- LIMPIEZA CRÍTICA DE SLOTS ---
        return [SlotSet("slot_vina", None)] 

# --- 3. ACCIÓN PARA RECOMENDAR TOUR ALEATORIO/FILTRADO POR VALLE ---
class ActionRecomendarTourDb(Action):
    def name(self) -> Text: 
        return "action_recomendar_tour_db"

    def run(self, dispatcher: CollectingDispatcher, tracker: Tracker, domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
        valle_deseado = tracker.get_slot("slot_valle")
        
        conn = None
        try:
            conn = _get_db_connection()
            cursor = conn.cursor()
            
            base_query = "SELECT nombre, descripcion_tour, horario_tour, valle, link_web FROM vinas WHERE descripcion_tour IS NOT NULL"
            valores = []
            
            if valle_deseado:
                base_query += " AND valle LIKE %s"
                valores.append(f"%{valle_deseado}%")
            
            base_query += " ORDER BY RAND() LIMIT 1;"
            
            cursor.execute(base_query, tuple(valores))
            resultado = cursor.fetchone()
            
            cursor.close()

            if resultado:
                nombre_vina, desc_tour, horario, valle, link = resultado
                respuesta_texto = f"¡Tengo una excelente recomendación de tour! Puedes visitar la viña **{nombre_vina}** en el {valle}. El tour es: {desc_tour} (Horario: {horario})."
                custom_payload = {"link": link, "link_text": f"Ver más sobre {nombre_vina}"}
                dispatcher.utter_message(text=respuesta_texto, json_message=custom_payload)
            else:
                dispatcher.utter_message(text=f"Lo siento, no encontré tours disponibles en el **{valle_deseado if valle_deseado else 'país'}**. Prueba con un valle más amplio.")

        except mysql.connector.Error as err:
            print(f"Error de base de datos en ActionRecomendarTourDb: {err}")
            dispatcher.utter_message(text="Tuvimos un problema al consultar la base de datos de tours. Por favor, inténtalo más tarde.")
        finally:
            if conn:
                conn.close()
            
        # --- LIMPIEZA CRÍTICA DE SLOTS ---
        return [SlotSet("slot_valle", None)]