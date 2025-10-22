from flask import Flask, render_template, request, redirect, url_for, flash
import mysql.connector
import subprocess
import os
from flask_login import LoginManager, UserMixin, login_user, logout_user, login_required, current_user
from werkzeug.security import generate_password_hash, check_password_hash

app = Flask(__name__)
app.secret_key = 'cambia_esto_por_algo_muy_secreto_y_largo!'

# --- Configuración de la DB ---
DB_CONFIG = {
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': 'vinai_db_normalizada'
}

# --- Variables Globales para procesos del Bot ---
rasa_core_process = None
rasa_actions_process = None
project_path = os.path.dirname(os.path.abspath(__file__))

# --- Configuración de Flask-Login ---
login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = 'login'
login_manager.login_message = u"Por favor, inicie sesión para acceder."
login_manager.login_message_category = "info"

# --- Modelo de Usuario (busca en DB) ---
class User(UserMixin):
    def __init__(self, id, username):
        self.id = id
        self.username = username
    
    @staticmethod
    def get(user_id):
        conn = get_db_connection()
        user = None
        if conn:
            try:
                cursor = conn.cursor(dictionary=True)
                cursor.execute("SELECT id, username FROM admins WHERE id = %s", (user_id,))
                user_data = cursor.fetchone()
                if user_data:
                    user = User(id=user_data['id'], username=user_data['username'])
                cursor.close()
                conn.close()
            except mysql.connector.Error as err:
                print(f"Error getting user by ID: {err}")
        return user

    @staticmethod
    def find_by_username(username):
        conn = get_db_connection()
        user = None
        if conn:
            try:
                cursor = conn.cursor(dictionary=True)
                cursor.execute("SELECT id, username FROM admins WHERE username = %s", (username,))
                user_data = cursor.fetchone()
                if user_data:
                    user = User(id=user_data['id'], username=user_data['username'])
                cursor.close()
                conn.close()
            except mysql.connector.Error as err:
                print(f"Error finding user by username: {err}")
        return user

@login_manager.user_loader
def load_user(user_id):
    return User.get(user_id)

# --- Conexión a DB ---
def get_db_connection():
    try:
        conn = mysql.connector.connect(**DB_CONFIG)
        return conn
    except mysql.connector.Error as err:
        print(f"Error de base de datos: {err}")
        return None

# --- Rutas de Login/Logout ---
@app.route('/login', methods=['GET', 'POST'])
def login():
    if current_user.is_authenticated:
        return redirect(url_for('admin_panel'))
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        conn = get_db_connection()
        user_data = None
        if conn:
            try:
                cursor = conn.cursor(dictionary=True)
                cursor.execute("SELECT id, username, password_hash FROM admins WHERE username = %s", (username,))
                user_data = cursor.fetchone()
                cursor.close()
                conn.close()
            except mysql.connector.Error as err:
                flash(f"Error de base de datos al buscar usuario: {err}", "error")
                return render_template('login.html')
        if user_data and check_password_hash(user_data['password_hash'], password):
            user = User(id=user_data['id'], username=user_data['username'])
            login_user(user)
            flash("Inicio de sesión exitoso.", "success")
            return redirect(url_for('admin_panel'))
        else:
            flash("Usuario o contraseña incorrectos.", "error")
    return render_template('login.html')

@app.route('/logout')
@login_required
def logout():
    logout_user()
    flash("Sesión cerrada exitosamente.", "success")
    return redirect(url_for('login'))

# ----------------------------------------------
# --- RUTAS DE ADMINISTRACIÓN (PROTEGIDAS) ---
# ----------------------------------------------

@app.route('/')
@login_required
def admin_panel():
    global rasa_core_process, rasa_actions_process
    core_status = "Detenido"
    actions_status = "Detenido"
    # === CORRECCIÓN: Comprueba si el proceso existe Y si está corriendo ===
    if rasa_core_process and rasa_core_process.poll() is None:
        core_status = "Corriendo"
    if rasa_actions_process and rasa_actions_process.poll() is None:
        actions_status = "Corriendo"
    return render_template('admin.html', core_status=core_status, actions_status=actions_status)

@app.route('/add_wine', methods=['POST'])
@login_required
def add_wine():
    nombre = request.form['nombre']
    cepa = request.form['cepa']
    ano = request.form['ano']
    tipo = request.form['tipo']
    vina_id = request.form['vina_id']
    link = request.form['link_compra']
    conn = get_db_connection()
    if conn:
        try:
            cursor = conn.cursor()
            query = "INSERT INTO vinos (nombre, cepa, ano, tipo, vina_id, link_compra) VALUES (%s, %s, %s, %s, %s, %s)"
            cursor.execute(query, (nombre, cepa, ano, tipo, vina_id, link))
            conn.commit()
            cursor.close()
            conn.close()
            flash(f"¡Vino '{nombre}' añadido con éxito!", 'success')
        except mysql.connector.Error as err:
            flash(f"Error al añadir el vino: {err}", 'error')
    return redirect(url_for('admin_panel'))

@app.route('/start_bot')
@login_required
def start_bot():
    global rasa_core_process, rasa_actions_process
    started_core = False
    started_actions = False

    try:
        # === CORRECCIÓN: Inicia solo si está detenido ===
        if rasa_core_process is None or rasa_core_process.poll() is not None:
            rasa_core_process = subprocess.Popen(['rasa', 'run', '--enable-api'], cwd=project_path, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            flash("Iniciando servidor Rasa Core...", 'info')
            started_core = True
        else:
            flash("El servidor Rasa Core ya estaba corriendo.", 'info')

        if rasa_actions_process is None or rasa_actions_process.poll() is not None:
            rasa_actions_process = subprocess.Popen(['rasa', 'run', 'actions'], cwd=project_path, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            flash("Iniciando servidor de Acciones...", 'info')
            started_actions = True
        else:
            flash("El servidor de Acciones ya estaba corriendo.", 'info')

        if not started_core and not started_actions:
             flash("Ambos servidores ya estaban corriendo.", 'warning')

    except Exception as e:
        flash(f"Error al iniciar los servidores: {e}", 'error')
        # Si falla al iniciar, resetea las variables por si acaso
        rasa_core_process = None
        rasa_actions_process = None
        
    return redirect(url_for('admin_panel'))

@app.route('/stop_bot')
@login_required
def stop_bot():
    global rasa_core_process, rasa_actions_process
    stopped_core = False
    stopped_actions = False

    if rasa_core_process and rasa_core_process.poll() is None:
        try:
            rasa_core_process.terminate() # Intenta terminarlo amablemente
            rasa_core_process.wait(timeout=5) # Espera 5 segundos
        except subprocess.TimeoutExpired:
            rasa_core_process.kill() # Si no termina, lo fuerza
        rasa_core_process = None
        flash("Servidor Rasa Core detenido.", 'success')
        stopped_core = True
        
    if rasa_actions_process and rasa_actions_process.poll() is None:
        try:
            rasa_actions_process.terminate()
            rasa_actions_process.wait(timeout=5)
        except subprocess.TimeoutExpired:
            rasa_actions_process.kill()
        rasa_actions_process = None
        flash("Servidor de Acciones detenido.", 'success')
        stopped_actions = True

    if not stopped_core and not stopped_actions:
        flash("Los servidores ya estaban detenidos.", 'info')
        
    return redirect(url_for('admin_panel'))

@app.route('/rasa_train')
@login_required
def rasa_train():
    global rasa_core_process, rasa_actions_process
    # === CORRECCIÓN: Verifica si los servidores están detenidos antes de entrenar ===
    core_running = rasa_core_process and rasa_core_process.poll() is None
    actions_running = rasa_actions_process and rasa_actions_process.poll() is None

    if core_running or actions_running:
        flash("¡Error! Debes detener los servidores del bot antes de re-entrenar.", 'error')
        return redirect(url_for('admin_panel'))
        
    try:
        flash("Iniciando re-entrenamiento... Esto puede tardar unos minutos.", 'info')
        # Usamos check=False para poder capturar el error si falla
        completed_process = subprocess.run(
            ['rasa', 'train'], 
            cwd=project_path, 
            capture_output=True, 
            text=True,
            check=False # Cambiado a False
        )
        
        # Revisamos si el comando falló
        if completed_process.returncode != 0:
             flash(f"Error durante el entrenamiento:\n{completed_process.stderr}", 'error')
        else:
            flash("¡Re-entrenamiento completado con éxito!", 'success')
            flash("Ahora puedes INICIAR los servidores para aplicar los cambios.", 'info')
            
    except Exception as e:
        flash(f"Error inesperado al ejecutar el entrenamiento: {e}", 'error')
        
    return redirect(url_for('admin_panel'))

# -------------------------------------------------------------
# --- FUNCIÓN PARA CREAR EL USUARIO ADMINISTRADOR INICIAL ---
# -------------------------------------------------------------
def create_initial_admin_user():
    """
    Crea el usuario administrador inicial si no existe.
    Usa 'username' y 'password_hash' para la inserción.
    """
    # Credenciales del usuario primario
    username = "EnoturismoAD"
    # ¡ADVERTENCIA! Esta contraseña es muy insegura. Cambiala inmediatamente.
    password = "123456" 
    
    # Genera el hash de la contraseña para almacenarla de forma segura
    password_hash = generate_password_hash(password)
    
    conn = get_db_connection()
    if conn:
        try:
            cursor = conn.cursor(dictionary=True)
            
            # 1. Verifica si el usuario ya existe
            cursor.execute("SELECT id FROM admins WHERE username = %s", (username,))
            user_exists = cursor.fetchone()
            
            if not user_exists:
                # 2. Si NO existe, lo insertamos. 
                query = "INSERT INTO admins (username, password_hash) VALUES (%s, %s)"
                cursor.execute(query, (username, password_hash))
                conn.commit()
                # Mensajes sin caracteres especiales para evitar errores de codificación
                print(f"--- Usuario administrador '{username}' creado exitosamente (Contraseña: {password}).")
                print("--- ADVERTENCIA: ¡CAMBIA LA CONTRASEÑA POR SEGURIDAD! ---")
            else:
                # Mensaje simplificado
                print(f"--- El usuario administrador '{username}' ya existe. No se creo de nuevo.")
                
            cursor.close()
            conn.close()
            
        except mysql.connector.Error as err:
            print(f"--- Error al crear el usuario administrador inicial: {err}")


# --- Iniciar el servidor del panel ---
if __name__ == '__main__':
    # Llama a la función para asegurar que el usuario administrador inicial exista
    create_initial_admin_user() 
    
    app.run(debug=True, port=8080)