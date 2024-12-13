extends Node2D

@export var Keyobject: PackedScene  # Escena exportada para asignar desde el editor
var positions: Array = []

# Nuevo atributo para almacenar la dirección de la flecha
var direction: int

func _ready():
	randomize()  # Inicializa la aleatoriedad
	positions.append($Objects/Catcher.global_position.x)
	positions.append($Objects/Catcher2.global_position.x)
	positions.append($Objects/Catcher3.global_position.x)
	positions.append($Objects/Catcher4.global_position.x)

func _spawn():
	if Keyobject:
		var KeyInstance = Keyobject.instantiate()  # Usa instantiate() en lugar de instance()
		var pos = $Marker2D.position
		pos.x = positions[randi() % positions.size()]  # Selecciona una posición aleatoria

		KeyInstance.position = pos  # Asigna la posición

		# Rotación predefinida basada en una dirección (por ejemplo, 0: izquierda, 1: derecha, etc.)
		direction = randi() % 4  # Asignar el número aleatorio a la dirección

		match direction:
			0:
				KeyInstance.rotation_degrees = 0  # Flecha hacia la izquierda
			1:
				KeyInstance.rotation_degrees = 180  # Flecha hacia la derecha
			2:
				KeyInstance.rotation_degrees = 90  # Flecha hacia arriba
			3:
				KeyInstance.rotation_degrees = -90  # Flecha hacia abajo

		# Pasar la dirección de la flecha al script de la flecha
		KeyInstance.set("direction", direction)

		add_child(KeyInstance)  # Agrega la instancia como hijo

func _on_timer_timeout():
	_spawn()
