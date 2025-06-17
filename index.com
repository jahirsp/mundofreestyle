<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8"> <!-- Primero por convención -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body {
            background-color: #fce8d6;
            font-family: 'Arial', sans-serif;
            color: #000000;
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #000000;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            font-size: 36px;
            padding: 10px 30px;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center; /* <-- Esto centra horizontalmente */
            gap: 0px;
        }
        .header-center {
            display: flex;
            align-items: center;
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
        }
        .rima-texto {
            width: 300px;  /* más ancho */
            height: 150px; /* más alto */
            object-fit: fill; /* fuerza a estirarse aunque se deforme */
        }
        
        
        
        header img {
            max-height: 120px;
        }
        
        header h1 {
            margin: 0;
            font-size: 36px;
        }

        .menu-container {
            display: flex;
            justify-content: flex-start;
            align-items: flex-start;
            padding: 20px;
            flex-wrap: wrap; /* Permite que los juegos se acomoden si hay muchos */
        }

        .game-option {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin: 20px;
            cursor: pointer;
            transition: transform 0.3s ease; /* Transición para el efecto hover */
        }

        .game-option img {
            max-width: 300px;
            max-height: 200px;
            object-fit: cover;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5);
        }

        .game-option span {
            margin-top: 10px;
            font-size: 18px;
            color: #c00000;
            text-transform: uppercase;
            font-weight: bold;
        }

        .game-option:hover {
            transform: scale(1.05); /* Restaurado el efecto de zoom */
        }
        
        .instagram-icon {
            color: #e8eaeb;
            font-size: 28px;
            text-decoration: none;
            padding-left: 10px;
            padding-right: 10px;
            transition: transform 0.3s ease;
        }
        
        .instagram-icon:hover {
            transform: scale(1.2);
            color: #ffffff;
        }

        /* Estilos para el modal de autenticación */
        .auth-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }

        .auth-modal-content {
            background: rgb(255, 255, 255);
            border-radius: 12px;
            width: 90%;
            max-width: 400px;
            padding: 30px;
            box-shadow: 0 5px 30px rgba(0, 0, 0, 0.3);
            animation: modalFadeIn 0.3s;
            position: relative;
        }

        @keyframes modalFadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .close-modal {
            position: absolute;
            top: 15px;
            right: 20px;
            font-size: 24px;
            cursor: pointer;
            color: #666;
        }

        .auth-tabs {
            display: flex;
            margin-bottom: 20px;
            border-bottom: 1px solid #eee;
        }

        .auth-tab {
            padding: 10px 20px;
            background: none;
            border: none;
            font-weight: 600;
            color: #777;
            cursor: pointer;
            position: relative;
        }

        .auth-tab.active {
            color: #000;
        }

        .auth-tab.active::after {
            content: "";
            position: absolute;
            bottom: -1px;
            left: 0;
            width: 100%;
            height: 2px;
            background: #e60606;/* barra de la parte de abajo de iniciar sescion y registrarse*/
        }

        .auth-form {
            display: none;
        }

        .auth-form.active {
            display: block;
        }

        .auth-form input {
            width: 100%;
            padding: 12px 15px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 15px;
        }

        .auth-form button {
            width: 100%;
            padding: 12px;
            background: #e30000;
            color: rgb(255, 255, 255);
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s;
            margin-top: 10px;
        }

        .auth-form button:hover {
            background: #0062c4;
        }

        .auth-footer {
            margin-top: 20px;
            text-align: center;
            font-size: 14px;
        }

        .auth-footer a {
            color: #ca0808;
            text-decoration: none;
        }

        /* Botones de auth en header */
        .auth-buttons {
            display: flex;
            gap: 10px;
            /*margin-left: auto;*/
        }

        .auth-btn {
            padding: 8px 16px;
            border: none;
            border-radius: 20px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
            font-size: 14px;
        }

        .login-btn {
            background-color: transparent;
            color: #ff0000;
            border: 2px solid #ff000d;
        }

        .login-btn:hover {
            background-color: rgba(0, 192, 255, 0.1);
        }

        .signup-btn {
            background-color: #ff0000;
            color: #000;
        }

        .signup-btn:hover {
            background-color: #fa0000;
            transform: translateY(-2px);
        }

        /* Responsive */
        @media (max-width: 768px) {
            header {
                flex-direction: column;
                padding: 10px;
            }
            
            .header-center {
                position: static;
                transform: none;
                margin: 10px 0;
            }
            
            .auth-buttons {
                margin-left: 0;
                margin-top: 10px;
            }
            
            .game-option img {
                max-width: 250px;
            }
        }

        /* OR */
            .social-login-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
            background: rgb(0, 0, 0);
            cursor: pointer;
            font-size: 14px;
            color: #333;
        }

        .social-login-btn:hover {
            background-color: #000000;
        }

        /* Agrega esto también */
        .auth-form {
            text-align: left;
        }

        .auth-form label {
            display: flex;
            align-items: center;
            font-size: 14px;
        }

        .forgot-password {
            text-align: right;
            display: block;
            margin-top: -20px;
            margin-bottom: 15px;
        }

        .divider {
            display: flex;
            align-items: center;
            margin: 15px 0;
            color: #777;
        }

        .divider::before, .divider::after {
            content: "";
            flex: 1;
            border-bottom: 1px solid #ddd;
        }

        .divider::before {
            margin-right: 10px;
        }

        .divider::after {
            margin-left: 10px;
        }
        
    </style>
</head>

<body>
    <header>
        <img src="imagenes/logoV2.png" alt="Logo" class="logo">
        <a href="https://www.instagram.com/rima_crudaoficial?igsh=bjR3bHR3ZGZiYXZi" target="_blank" class="instagram-icon">
            <i class="fab fa-instagram"></i>
        </a>

        <!-- Botones de Auth (alineados a la derecha) -->
        <div class="auth-buttons">
                <button class="auth-btn login-btn" id="openLoginModal">Iniciar Sesión</button>
                <button class="auth-btn signup-btn" id="openRegisterModal">Registrarse</button>
        </div>

    </header>

    <!-- Juegos Estrella -->
    <div style="padding: 20px;">
        <h2 style="color: #c00000; font-size: 28px; margin-bottom: 10px;">🎯 Solo Para Maestros</h2>
        <div class="menu-container">
            <!-- Juego Estrella 1 -->
            <div class="game-option" onclick="startFreestyleGame()">
                <img src="imagenes/vistaprevia1.png" alt="Vista previa Campeones de Freestyle">
                <span>FREESTYLER grid</span>
            </div>
    
            <!-- Juego Estrella 2 -->
            <div class="game-option" onclick="startFreestyleMaster()">
                <img src="imagenes/vistaprevia2.png" alt="Vista previa Freestyle Master">
                <span>4 FOTOS 1 FREESTYLeR</span>
            </div>
        </div>
    </div>
    
    <!-- Modal de Autenticación -->
    <!-- Modal de Autenticación -->
<div id="authModal" class="auth-modal">
    <div class="auth-modal-content">
        <span class="close-modal">&times;</span>
        <div class="auth-tabs">
            <button class="auth-tab active" data-tab="login">Iniciar Sesión</button>
            <button class="auth-tab" data-tab="register">Registrarse</button>
        </div>
        
        <!-- Formulario Login (modificado)**************************************************************** -->
        <form id="loginForm" class="auth-form active">
            <input type="email" placeholder="Correo electrónico" required>
            <input type="password" placeholder="Contraseña" required>
            <button type="submit">Ingresar</button>
            
            <!-- Nuevos elementos agregados -->
            <div style="display: flex; justify-content: space-between; margin: 10px 0; font-size: 14px;">
                <label style="display: flex; align-items: center;">
                    <input type="checkbox" style="margin-right: 5px;"> Recuérdame
                </label>
                <a href="#" style="color: #ca0808; text-decoration: none;">¿Olvidaste tu contraseña?</a>
            </div>
            
            <div style="display: flex; align-items: center; margin: 15px 0; color: #777;">
                <div style="flex-grow: 1; height: 1px; background-color: #ddd;"></div>
                <div style="padding: 0 10px;">OR</div>
                <div style="flex-grow: 1; height: 1px; background-color: #ddd;"></div>
            </div>
            
            <div style="display: flex; flex-direction: column; gap: 10px; margin-bottom: 15px;">
                <button type="button" style="display: flex; align-items: center; justify-content: center; padding: 10px; border: 1px solid #ffffff; border-radius: 8px; background: rgb(216, 13, 13); cursor: pointer;">
                    <i class="fab fa-apple" style="margin-right: 10px; font-size: 18px;"></i> Continuar con Apple
                </button>
                <button type="button" style="display: flex; align-items: center; justify-content: center; padding: 10px; border: 1px solid #b10707; border-radius: 8px; background: rgb(216, 13, 13); cursor: pointer;">
                    <i class="fab fa-google" style="margin-right: 10px; font-size: 18px; color: #DB4437;"></i> Continuar con Google
                </button>
                <button type="button" style="display: flex; align-items: center; justify-content: center; padding: 10px; border: 1px solid #c40000; border-radius: 8px; background: rgb(216, 13, 13); cursor: pointer;">
                    <i class="fab fa-facebook-f" style="margin-right: 10px; font-size: 18px; color: #1877F2;"></i> Continuar con Facebook
                </button>
            </div>
            
            <div class="auth-footer">
                <p>¿No tienes cuenta? <a href="#" id="switchToRegister">Regístrate</a></p>
            </div>
        </form>
        
        <!-- Formulario Registro (modificado)**************************************************************** -->
        <form id="registerForm" class="auth-form">
            <input type="text" placeholder="Nombre de usuario" required>
            <input type="email" placeholder="Correo electrónico" required>
            <input type="password" placeholder="Contraseña (mín. 6 caracteres)" required>
            <button type="submit">Crear Cuenta</button>
            
            <!-- Nuevos elementos agregados -->
            <div style="display: flex; align-items: center; margin: 15px 0; color: #777;">
                <div style="flex-grow: 1; height: 1px; background-color: #ddd;"></div>
                <div style="padding: 0 10px;">OR</div>
                <div style="flex-grow: 1; height: 1px; background-color: #ddd;"></div>
            </div>
            
            <div style="display: flex; flex-direction: column; gap: 10px; margin-bottom: 15px;">
                <button type="button" style="display: flex; align-items: center; justify-content: center; padding: 10px; border: 1px solid #ddd; border-radius: 8px; background: rgb(216, 13, 13); cursor: pointer;">
                    <i class="fab fa-apple" style="margin-right: 10px; font-size: 18px;"></i> Continuar con Apple
                </button>
                <button type="button" style="display: flex; align-items: center; justify-content: center; padding: 10px; border: 1px solid #ddd; border-radius: 8px; background: rgb(216, 13, 13); cursor: pointer;">
                    <i class="fab fa-google" style="margin-right: 10px; font-size: 18px; color: #DB4437;"></i> Continuar con Google
                </button>
                <button type="button" style="display: flex; align-items: center; justify-content: center; padding: 10px; border: 1px solid #ddd; border-radius: 8px; background: rgb(216, 13, 13); cursor: pointer;">
                    <i class="fab fa-facebook-f" style="margin-right: 10px; font-size: 18px; color: #1877F2;"></i> Continuar con Facebook
                </button>
            </div>
            
            <div class="auth-footer">
                <p>¿Ya tienes cuenta? <a href="#" id="switchToLogin">Inicia sesión</a></p>
            </div>
        </form>
    </div>
</div> <!-- fin del modal -->

    <!-- Otros Juegos (descomenta y edita cuando tengas más) -->
    <!--
    <div style="padding: 20px;">
        <h2 style="color: #00c0ff; font-size: 24px; margin-bottom: 10px;">🎮 Otros Juegos</h2>
        <div class="menu-container">
            <div class="game-option" onclick="startOtherGame()">
                <img src="imagenes/vistaprevia_otro.png" alt="Otro juego">
                <span>Otro Juego</span>
            </div>
        </div>
    </div>
    -->

    <script>
        function startFreestyleGame() {
            window.location.href = 'freestyle_game.html';
        }

        function startFreestyleMaster() {
            window.location.href = 'freestyle_master.html';
        }

        // Funcionalidad del modal de autenticación
        const authModal = document.getElementById('authModal');
        const openLoginModal = document.getElementById('openLoginModal');
        const openRegisterModal = document.getElementById('openRegisterModal');
        const closeModalBtn = document.querySelector('.close-modal');
        const authTabs = document.querySelectorAll('.auth-tab');
        const loginForm = document.getElementById('loginForm');
        const registerForm = document.getElementById('registerForm');
        const switchToRegister = document.getElementById('switchToRegister');
        const switchToLogin = document.getElementById('switchToLogin');

        function openAuthModal(tab) {
            authModal.style.display = 'flex';
            switchAuthTab(tab);
        }

        function closeAuthModal() {
            authModal.style.display = 'none';
        }

        function switchAuthTab(tabName) {
            authTabs.forEach(tab => {
                tab.classList.toggle('active', tab.dataset.tab === tabName);
            });
            
            loginForm.classList.toggle('active', tabName === 'login');
            registerForm.classList.toggle('active', tabName === 'register');
        }

        openLoginModal.addEventListener('click', () => openAuthModal('login'));
        openRegisterModal.addEventListener('click', () => openAuthModal('register'));
        closeModalBtn.addEventListener('click', closeAuthModal);

        authTabs.forEach(tab => {
            tab.addEventListener('click', () => switchAuthTab(tab.dataset.tab));
        });

        switchToRegister.addEventListener('click', (e) => {
            e.preventDefault();
            switchAuthTab('register');
        });

        switchToLogin.addEventListener('click', (e) => {
            e.preventDefault();
            switchAuthTab('login');
        });

        window.addEventListener('click', (e) => {
            if (e.target === authModal) {
                closeAuthModal();
            }
        });

        // Agrega nuevas funciones aquí si tienes más juegos
    </script>
    
    <!-- Modal de Autenticación -->
<div id="authModal" class="auth-modal">
    <div class="auth-modal-content">
        <span class="close-modal">&times;</span>
        <div class="auth-tabs">
            <button class="auth-tab active" data-tab="login">Iniciar Sesión</button>
            <button class="auth-tab" data-tab="register">Registrarse</button>
        </div>
        
        <!-- Formulario Login -->
        <form id="loginForm" class="auth-form active">
            <input type="email" placeholder="Correo electrónico" required>
            <input type="password" placeholder="Contraseña" required>
            <button type="submit">Ingresar</button>
        </form>
        
        <!-- Formulario Registro -->
        <form id="registerForm" class="auth-form">
            <input type="text" placeholder="Nombre de usuario" required>
            <input type="email" placeholder="Correo electrónico" required>
            <input type="password" placeholder="Contraseña (mín. 6 caracteres)" required>
            <button type="submit">Crear Cuenta</button>
        </form>
        
        <div class="auth-footer">
            <p>¿No tienes cuenta? <a href="#" id="switchToRegister">Regístrate</a></p>
            <p>¿Ya tienes cuenta? <a href="#" id="switchToLogin">Inicia sesión</a></p>
        </div>
    </div>
</div>
</body>

</html>
