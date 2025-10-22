document.addEventListener('DOMContentLoaded', () => {
    // --- Selección de Elementos del DOM ---
    const chatContainer = document.getElementById('chat-container');
    const chatBubble = document.getElementById('chat-bubble');
    const closeButton = document.getElementById('close-button');
    const messagesDiv = document.getElementById('messages');
    const userInput = document.getElementById('user-input');
    const sendButton = document.getElementById('send-button');
    const voiceButton = document.getElementById('voice-button');
    const speakerButton = document.getElementById('speaker-button');
    const typingIndicator = document.getElementById('typing-indicator');

    // --- Configuración y Constantes ---
    const RASA_API_URL = 'http://localhost:5005/webhooks/rest/webhook';
    const BOT_NAME = 'VinAI Sommelier'; 
    
    // === CORRECCIÓN DEFINITIVA: Generador de Avatares Local ===
    // Esta función crea un avatar como una imagen SVG, eliminando la dependencia de servicios externos.
    function createAvatarUrl(text, backgroundColor, textColor) {
        const svg = `
            <svg xmlns="http://www.w3.org/2000/svg" width="35" height="35">
                <circle cx="17.5" cy="17.5" r="17.5" fill="${backgroundColor}" />
                <text x="50%" y="50%" text-anchor="middle" dy=".3em" fill="${textColor}" font-size="16" font-family="Montserrat, sans-serif" font-weight="600">${text}</text>
            </svg>
        `;
        // Codificamos el SVG para usarlo como URL de datos (Data URL)
        return `data:image/svg+xml;base64,${btoa(svg)}`;
    }

    const BOT_AVATAR_URL = createAvatarUrl('AI', '#1A1A1A', '#D4AF37'); 
    const USER_AVATAR_URL = createAvatarUrl('TÚ', '#D4AF37', '#1A1A1A'); 

    // --- Variables de Estado ---
    let recognition; 
    let isListening = false;
    let isSpeakingEnabled = true; 
    
    // --- Funciones Principales ---
    function toggleChat() {
        chatContainer.classList.toggle('open');
        if (chatContainer.classList.contains('open') && messagesDiv.children.length === 0) {
            sendPayload('/saludar', ''); 
            userInput.focus();
        }
    }

    function addMessage(sender, text, customData = {}) {
        if (sender === 'user' && !text.trim()) {
            return;
        }

        const messageDiv = document.createElement('div');
        messageDiv.classList.add('message', sender);

        const avatar = document.createElement('img');
        avatar.classList.add('avatar');
        avatar.src = sender === 'bot' ? BOT_AVATAR_URL : USER_AVATAR_URL;
        avatar.alt = sender === 'bot' ? BOT_NAME : 'Tú';

        const bubble = document.createElement('div');
        bubble.classList.add('bubble');
        
        const textElement = document.createElement('div');
        textElement.innerHTML = text;
        bubble.appendChild(textElement);

        if (customData.link) {
            const linkElement = document.createElement('a');
            linkElement.href = customData.link;
            linkElement.target = '_blank';
            linkElement.textContent = customData.link_text || 'Ver Detalle';
            bubble.appendChild(linkElement);
        }

        messageDiv.appendChild(avatar);
        messageDiv.appendChild(bubble);
        messagesDiv.appendChild(messageDiv);
        messagesDiv.scrollTop = messagesDiv.scrollHeight; 
    }

    function showTypingIndicator(show) {
        typingIndicator.style.display = show ? 'flex' : 'none';
        if (show) {
            messagesDiv.scrollTop = messagesDiv.scrollHeight;
        }
    }

    async function sendMessageToRasa(message) {
        if (!message.trim()) return; 

        addMessage('user', message);
        userInput.value = ''; 
        showTypingIndicator(true); 

        try {
            const response = await fetch(RASA_API_URL, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ sender: 'user', message: message })
            });

            const data = await response.json();
            showTypingIndicator(false); 

            if (data && data.length > 0) {
                for (const botMessage of data) {
                    const messageText = botMessage.text || '';
                    const custom = botMessage.custom || {};
                    
                    addMessage('bot', messageText, { 
                        link: custom.link, 
                        link_text: custom.link_text
                    });
                    
                    if (isSpeakingEnabled && messageText) {
                        speakText(messageText);
                    }
                }
            } else {
                addMessage('bot', 'Lo siento, no pude procesar tu solicitud. ¿Podrías reformularla?');
            }
        } catch (error) {
            console.error('Error al comunicarse con Rasa:', error);
            showTypingIndicator(false);
            addMessage('bot', 'Hubo un error al conectar con el asistente. Por favor, inténtalo de nuevo más tarde.');
        }
    }
    
    async function sendPayload(payload, title) {
        addMessage('user', title); 
        showTypingIndicator(true);
        try {
            const response = await fetch(RASA_API_URL, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ sender: 'user', message: payload })
            });
            const data = await response.json();
            showTypingIndicator(false);

            if (data && data.length > 0) {
                for (const botMessage of data) {
                    const messageText = botMessage.text || '';
                    const custom = botMessage.custom || {};
                    
                    addMessage('bot', messageText, { 
                        link: custom.link, 
                        link_text: custom.link_text
                    });
                    
                    if (isSpeakingEnabled && messageText) {
                        speakText(messageText);
                    }
                }
            }
        } catch (error) {
            console.error('Error al enviar payload a Rasa:', error);
            showTypingIndicator(false);
            addMessage('bot', 'Hubo un error al procesar tu selección. Por favor, inténtalo de nuevo.');
        }
    }

    function initSpeechRecognition() {
        if (!('webkitSpeechRecognition' in window)) {
            voiceButton.style.display = 'none'; 
            return;
        }

        recognition = new webkitSpeechRecognition();
        recognition.continuous = false; 
        recognition.lang = 'es-ES'; 
        recognition.interimResults = false; 

        recognition.onstart = () => { isListening = true; voiceButton.classList.add('active'); };
        recognition.onresult = (event) => {
            const transcript = event.results[event.results.length - 1][0].transcript;
            userInput.value = transcript; 
            sendMessageToRasa(transcript); 
        };
        recognition.onerror = (event) => { console.error("Error de voz:", event.error); isListening = false; voiceButton.classList.remove('active'); };
        recognition.onend = () => { isListening = false; voiceButton.classList.remove('active'); };
    }

    function speakText(text) {
        if (!isSpeakingEnabled || !('speechSynthesis' in window)) return;
        speechSynthesis.cancel();
        const utterance = new SpeechSynthesisUtterance(text);
        utterance.lang = 'es-ES'; 
        utterance.rate = 1.2; 
        speechSynthesis.speak(utterance);
    }

    // --- Inicialización y Asignación de Eventos ---
    initSpeechRecognition();

    chatBubble.addEventListener('click', toggleChat);
    closeButton.addEventListener('click', toggleChat);
    sendButton.addEventListener('click', () => sendMessageToRasa(userInput.value));
    userInput.addEventListener('keypress', (e) => { if (e.key === 'Enter') sendMessageToRasa(userInput.value); });

    voiceButton.addEventListener('click', () => {
        if (!recognition) return;
        if (isListening) { recognition.stop(); } 
        else { try { recognition.start(); } catch(e) { console.error("Error al iniciar escucha:", e); } }
    });

    speakerButton.addEventListener('click', () => {
        isSpeakingEnabled = !isSpeakingEnabled;
        speakerButton.innerHTML = isSpeakingEnabled ? '<i class="fas fa-volume-up"></i>' : '<i class="fas fa-volume-mute"></i>';
        if (!isSpeakingEnabled) speechSynthesis.cancel(); 
    });

    document.querySelectorAll('#quick-replies button').forEach(button => {
        button.addEventListener('click', () => {
            sendPayload(button.dataset.payload, button.textContent);
        });
    });
});