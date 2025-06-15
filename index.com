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
            color: #00c0ff;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            font-size: 36px;
            padding: 10px 30px;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center; /* <-- Esto centra horizontalmente */
            gap: 0px;
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
        
    </style>
</head>

<body>
    <header>
        <img src="imagenes/logoV2.png" alt="Logo" class="logo">
        <a href="https://www.instagram.com/rima_crudaoficial?igsh=bjR3bHR3ZGZiYXZi" target="_blank" class="instagram-icon">
            <i class="fab fa-instagram"></i>
        </a>

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

        // Agrega nuevas funciones aquí si tienes más juegos
    </script>
</body>

</html>
