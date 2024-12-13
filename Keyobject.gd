extends Area2D


const GRAVITY = 150

var inside_area = false
var selected_key = 0


func _process(delta):
	position.y += GRAVITY * delta

	if inside_area:
		if Input.is_key_pressed(selected_key):
			print("debug=> que bien!")
			queue_free()


func spawn(key:int, pos:Vector2) -> void:
	position = pos
	match key:
		0:
			selected_key = "left"  # Usar "ui_left" para la tecla izquierda
			rotation_degrees = 0
		1:
			selected_key = KEY_RIGHT  # Usar "ui_right" para la tecla derecha
			rotation_degrees = 180
		2:
			selected_key = KEY_UP  # Usar "ui_up" para la tecla arriba
			rotation_degrees = 90
		3:
			selected_key = KEY_DOWN # Usar "ui_down" para la tecla abajo
			rotation_degrees = -90




func _on_area_entered(area):
	inside_area = true
	print("debug=> que bien!")

func _on_area_exited(area):
	inside_area = false
