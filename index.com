<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mundo Freestyle</title>
    <style>
        body {
            background-color: #000005;
            font-family: 'Arial', sans-serif;
            color: white;
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #000000; /* Fondo negro */
            color: #00c0ff; /* Color cian */
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; /* Fuente mejorada */
            font-size: 36px;
            padding: 20px 40px; /* Añadí más padding para que se vea espacioso */
            width: 100%;
            display: flex;
            align-items: center;
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
        }

        .game-option {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin: 20px;
            cursor: pointer;
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
            color: #00c0ff;
            text-transform: uppercase;
            font-weight: bold;
        }

        .game-option:hover {
            transform: scale(1.05);
            transition: transform 0.3s ease;
        }

        .game-option:active {
            transform: scale(1);
        }
    </style>
</head>

<body>
    <header>
        <h1>Mundo Freestyle</h1>
    </header>

    <div class="menu-container">
        <div class="game-option" onclick="startFreestyleGame()">
            <!-- Vista previa del juego "Campeones de Freestyle" -->
            <img src="imagenes/vistaprevia1.png" alt="Vista previa Campeones de Freestyle">
            <span>Campeones de Freestyle</span>
        </div>
    </div>

    <script>
        // Función para iniciar el juego "Campeones de Freestyle"
        function startFreestyleGame() {
            // Redirige al juego "Campeones de Freestyle"
            window.location.href = 'freestyle_game.html';  // Cambia 'freestyle_game.html' a la ruta correcta
        }
    </script>
</body>

</html>
