extends Node2D

@export var Keyobject: PackedScene  # Escena exportada para asignar desde el editor
var positions: Array = []  # Array para almacenar las posiciones de los catchers
var lives = 3
var score = 0  # Variable para almacenar el puntaje
var direction: int
var initial_wait_time = 0.775
var min_wait_time = 0.25
var elapsed_time = 0.0  # 
var k = -log(min_wait_time / initial_wait_time) / 120  # Calculamos k solo una vez

func _ready():
	randomize()  # Inicializa la aleatoriedad
	positions.append($Objects/Catcher.global_position.x)  # Posición X del Catcher 1
	positions.append($Objects/Catcher2.global_position.x)  # Posición X del Catcher 2
	positions.append($Objects/Catcher3.global_position.x)  # Posición X del Catcher 3
	positions.append($Objects/Catcher4.global_position.x)  # Posición X del Catcher 4

func _spawn():
	if Keyobject:
		var KeyInstance = Keyobject.instantiate()
		KeyInstance.Mundo_script = self  # Pasamos la referencia al script principal

		var pos = $Marker2D.position  # Posición del Marker2D como base
		KeyInstance.position = pos  # Asigna la posición de la flecha

		direction = randi() % 4  # Dirección aleatoria

		var catcher_position = Vector2(positions[direction], pos.y)  # Usamos la X del Catcher

		KeyInstance.position = catcher_position

		match direction:
			0: KeyInstance.rotation_degrees = 0  # Flecha hacia la derecha
			1: KeyInstance.rotation_degrees = 180  # Flecha hacia la izquierda
			2: KeyInstance.rotation_degrees = 90  # Flecha hacia arriba
			3: KeyInstance.rotation_degrees = -90  # Flecha hacia abajo

		KeyInstance.set("direction", direction)

		add_child(KeyInstance)  # Agrega la instancia de la flecha

func _on_timer_timeout():
	elapsed_time += $start_timer.wait_time  # Acumula el tiempo
	var new_wait_time = initial_wait_time * exp(-k * elapsed_time)
	$start_timer.wait_time = max(new_wait_time, min_wait_time)
	print("Wait Time: ", $start_timer.wait_time)
	_spawn()  # Llama a la generación de flechas

# Función para aumentar el puntaje
func increase_score():
	score += 200  # Incrementa el puntaje en 200
	print("debug=> ¡Acierto! Puntaje:", score)  # Imprime el puntaje actual

# Función para reducir una vida (esto lo dejas igual)
func reduce_life():
	if lives > 0:
		lives -= 1
		print("debug=> Fallo! Vidas restantes:", lives)
		if lives <= 0:
			print("debug=> ¡Juego terminado!")
			get_tree().quit()  # Cierra el juego
