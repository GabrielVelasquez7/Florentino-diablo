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


func spawn(key:int, pos:Vector2)->void:
	position = pos
	match key:
		0:
			selected_key = KEY_LEFT
			rotation_degrees = 0
		1:
			selected_key = KEY_RIGHT
			rotation_degrees = 180
		2:
			selected_key = KEY_UP
			rotation_degrees = 90
		3:
			selected_key = KEY_DOWN
			rotation_degrees = -90



func _on_area_entered(area):
	inside_area = true


func _on_area_exited(area):
	inside_area = false
