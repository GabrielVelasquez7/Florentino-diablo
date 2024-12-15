extends Node2D

@export var Keyobject: PackedScene  # Escena exportada para asignar desde el editor
var positions: Array = []  # Array para almacenar las posiciones de los catchers
var lives = 3
# Nuevo atributo para almacenar la dirección de la flecha
var direction: int

func _ready():
	randomize()  # Inicializa la aleatoriedad
	# Guardamos las posiciones globales de los catchers, pero solo las coordenadas X
	positions.append($Objects/Catcher.global_position.x)  # Solo la posición X del Catcher 1
	positions.append($Objects/Catcher2.global_position.x)  # Solo la posición X del Catcher 2
	positions.append($Objects/Catcher3.global_position.x)  # Solo la posición X del Catcher 3
	positions.append($Objects/Catcher4.global_position.x)  # Solo la posición X del Catcher 4


func _spawn():
		if Keyobject:
			var KeyInstance = Keyobject.instantiate()
			# Asignamos la referencia a main.gd
			KeyInstance.main_script = self  # Esto pasa la referencia de main.gd al script de la flecha

		# Asigna una posición aleatoria al KeyInstance (usando el Marker2D como base)
			var pos = $Marker2D.position  # Usar la posición del Marker2D como la posición inicial
			KeyInstance.position = pos  # Asigna la posición de la flecha

			# Asigna una dirección aleatoria a la flecha
			direction = randi() % 4  # Asignar un número aleatorio entre 0 y 3 para la dirección

			# Coloca la flecha en la posición del catcher adecuado, pero solo usa la posición X
			var catcher_position = Vector2(positions[direction], pos.y)  # Solo tomamos la X de la posición del catcher y mantenemos la Y del Marker2D

		# Coloca la flecha en la posición del catcher correspondiente
			KeyInstance.position = catcher_position

			# Según la dirección, rota la flecha
			match direction:
				0:
					KeyInstance.rotation_degrees = 0  # Flecha hacia la derecha
				1:
					KeyInstance.rotation_degrees = 180  # Flecha hacia la izquierda
				2:
					KeyInstance.rotation_degrees = 90  # Flecha hacia arriba
				3:
					KeyInstance.rotation_degrees = -90  # Flecha hacia abajo

			# Pasar la dirección de la flecha al script de la flecha
			KeyInstance.set("direction", direction)

			add_child(KeyInstance)  # Agrega la instancia como hijo


func _on_timer_timeout():

		_spawn()
		var timer = $start_timer  # Suponiendo que el temporizador es un nodo llamado "Timer"
		timer.wait_time = max(timer.wait_time - 0.0011, 0.25)  # Reducir el tiempo de espera en 0.1, pero no menos de 0.1

	
	var lives = 3  # Número de vidas en main.gd

# Función para reducir una vida
func reduce_life():
	if lives > 0:
		lives -= 1  # Reduce una vida
		print("debug=> Fallo! Vidas restantes:", lives)
		if lives <= 0:
			print("debug=> ¡Juego terminado!")
			get_tree().quit()  # Cierra el juego cuando las vidas llegan a 0

