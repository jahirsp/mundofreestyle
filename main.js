const niveles = [
    {
        tiempo: 60,
        respuestas: {
            "chuty": { key: "2023", img: "imagenes/Chuty.png" },
            "adrian": { key: "2008", img: "imagenes/adrian.png" },
            "dtoke": { key: "2013", img: "imagenes/dtoke.png" },
            "skone": { key: "2018", img: "imagenes/skone.png" },
            "aczino": { keys: ["2015", "2019"], img: "imagenes/aczino.png" },
            "nadie": { key: "2021", img: "imagenes/nadie.png" },
            "gazir": { key: "2020", img: "imagenes/gazir.png" },
            "larrix": { key: "L2023", img: "imagenes/larrix.png" }
        }
    },
    {
        tiempo: 60,
        respuestas: {
            "rapder": { key: "0-0", img: "imagenes/rapder.png" },
            "zasko": { key: "0-1", img: "imagenes/zasko.png" },
            "jony beltran": { key: "0-2", img: "imagenes/jony.png" },
            "blon": { key: "1-0", img: "imagenes/blon.png" },
            "lets": { key: "1-1", img: "imagenes/lets.png" },
            "jaze": { key: "1-2", img: "imagenes/jaze.png" },
            "rc": { key: "2-0", img: "imagenes/rc.png" },
            "kodigo": { key: "2-1", img: "imagenes/kodigo.png" },
            "smoke": { key: "2-2", img: "imagenes/smoke.png" }
        }
    }
];

let nivelActual = 0;
let timeLeft = 0;
let countdown;

function mostrarDerrota() {
    const modal = document.createElement('div');
    modal.id = 'modalDerrota';
    modal.style.position = 'fixed';
    modal.style.top = '0';
    modal.style.left = '0';
    modal.style.width = '100%';
    modal.style.height = '100%';
    modal.style.backgroundColor = 'rgba(0,0,0,0.8)';
    modal.style.display = 'flex';
    modal.style.flexDirection = 'column';
    modal.style.alignItems = 'center';
    modal.style.justifyContent = 'center';
    modal.style.color = 'white';
    modal.style.zIndex = '1000';

    modal.innerHTML = `
        <h2>¡Has perdido!</h2>
        <p>Se te acabó el tiempo.</p>
        <button id="intentarDeNuevoBtn" style="padding: 10px 20px; margin-top: 20px;">Intentar de nuevo</button>
    `;

    document.body.appendChild(modal);

    document.getElementById('intentarDeNuevoBtn').addEventListener('click', () => {
        modal.remove();
        cargarNivel(); // reinicia el mismo nivel
    });
}

function cargarNivel() {
    const nivel = niveles[nivelActual];
    timeLeft = tiempoDificultad;
    document.querySelectorAll('.input-cell').forEach(cell => cell.innerHTML = `<span>${cell.dataset.key}</span>`);
    document.getElementById('freestylerInput').value = '';
    document.getElementById('timer').style.display = 'block';
    document.getElementById('inputArea').style.display = 'flex';
    document.getElementById('nextLevelBtn').style.display = 'none';


    clearInterval(countdown);
    updateTimer();
    countdown = setInterval(() => {
        timeLeft--;
        updateTimer();
        if (timeLeft <= 0) {
            clearInterval(countdown);
            mostrarDerrota();
        }        
    }, 1000);
}

function updateTimer() {
    const minutes = Math.floor(timeLeft / 60);
    const seconds = timeLeft % 60;
    document.getElementById('timer').textContent = `Tiempo restante: ${minutes}:${seconds < 10 ? '0' + seconds : seconds}`;
}

let tiempoDificultad = 0; // al inicio del archivo
function startGame() {
    const difficulty = document.getElementById('difficultySelect').value;
    if (difficulty === "none") {
        alert("Selecciona una dificultad");
        return;
    }

    // Cambiar el tiempo según dificultad
    if (difficulty === "facil") {
        tiempoDificultad = 90;
    } else if (difficulty === "medio") {
        tiempoDificultad = 60;
    } else if (difficulty === "dificil") {
        tiempoDificultad = 30;
    }

    document.getElementById('difficultyModal').style.display = 'none';
    cargarNivel();
}


document.getElementById('submitBtn').addEventListener('click', () => {
    const input = document.getElementById('freestylerInput');
    const name = input.value.trim().toLowerCase();

    if (!name) {
        alert("Por favor, ingresa un nombre.");
        return;
    }

    const respuestas = niveles[nivelActual].respuestas;
    const answer = respuestas[name];

    if (answer) {
        const keys = Array.isArray(answer.keys) ? answer.keys : [answer.key]; // admite key o keys
        for (const key of keys) {
            const cells = document.querySelectorAll(`.input-cell[data-key="${key}"]`);
            for (const cell of cells) {
                if (!cell.querySelector('img')) {
                    const img = document.createElement('img');
                    img.src = answer.img;
                    img.alt = name;
                    img.classList.add('freestyler-img');
                    cell.innerHTML = '';
                    cell.appendChild(img);
                    input.value = '';
                    // Verificar si todas las celdas del nivel están llenas
                    //nueva logica para pasar nivel
                    const nivel = niveles[nivelActual];
                    let completado = true;

                    for (const key in nivel.respuestas) {
                        const keys = Array.isArray(nivel.respuestas[key].keys) ? nivel.respuestas[key].keys : [nivel.respuestas[key].key];
                        for (const k of keys) {
                            const cells = document.querySelectorAll(`.input-cell[data-key="${k}"]`);
                            for (const cell of cells) {
                                if (!cell.querySelector('img')) {
                                    completado = false;
                                }
                            }
                        }
                    }

                    if (completado) {
                        clearInterval(countdown); // Detener temporizador
                        document.getElementById('nextLevelBtn').style.display = 'block'; // Mostrar botón siguiente
                    }

                    return; // solo llena una casilla por intento
                }
            }
        }
        alert("Ya has colocado todas las imágenes posibles para esta respuesta.");
    } else {
        alert("Nombre incorrecto, intenta de nuevo.");
    }
});


document.getElementById('nextLevelBtn').addEventListener('click', () => {
    nivelActual++;
    if (nivelActual >= niveles.length) {
        alert("¡No hay más niveles por ahora!");
        nivelActual = niveles.length - 1; // no pasar del último
        return;
    }
    cargarNivel();
});
