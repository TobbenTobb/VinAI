@echo off
ECHO Iniciando Servidores de VinAI...

:: Asumiendo que tu entorno virtual se llama 'venv'
:: Si no usas uno, elimina ".\venv\Scripts\activate &&" de las líneas de abajo.

:: Inicia el Servidor 1: Frontend (index.html)
ECHO Iniciando Servidor Frontend (http://localhost:8000)
start "Frontend" python -m http.server 8000

:: Inicia el Servidor 2: Backend (admin_app.py)
ECHO Iniciando Servidor Backend (http://localhost:8080)
start "Backend" cmd /k ".\venv\Scripts\activate && python admin_app.py"

:: Inicia el Servidor 3: Rasa Actions (Lógica)
ECHO Iniciando Servidor Rasa Actions (Puerto 5055)
start "Rasa Actions" cmd /k ".\venv\Scripts\activate && rasa run actions"

:: Inicia el Servidor 4: Rasa Core (IA)
ECHO Iniciando Servidor Rasa Core (Puerto 5005)
start "Rasa Core" cmd /k ".\venv\Scripts\activate && rasa run --enable-api --cors ""*"""