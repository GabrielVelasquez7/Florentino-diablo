extends Node2D

@export var Keyobject: PackedScene  # Escena exportada para asignar desde el editor
var positions: Array = []

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
		pos.x = positions[randi() % positions.size()]
		KeyInstance.position = pos
		add_child(KeyInstance)

func _on_timer_timeout():
	_spawn()
