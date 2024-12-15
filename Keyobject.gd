extends Area2D

const GRAVITY = 150

var direction = -1
var key_pressed = false
var inside_area = false
var main_script : Node2D  # Para almacenar la referencia a main.gd

func _process(delta):
	position.y += GRAVITY * delta

	if inside_area and key_pressed:
		if is_correct_key_pressed():
			queue_free()

func is_correct_key_pressed():
	match direction:
		0:
			return Input.is_action_pressed("ui_left")
		1:
			return Input.is_action_pressed("ui_right")
		2:
			return Input.is_action_pressed("ui_up")
		3:
			return Input.is_action_pressed("ui_down")
		_:
			return false

func _input(event):
	if event.is_action_pressed("ui_left") and direction == 0 and inside_area:
		key_pressed = true
	elif event.is_action_pressed("ui_right") and direction == 1 and inside_area:
		key_pressed = true
	elif event.is_action_pressed("ui_up") and direction == 2 and inside_area:
		key_pressed = true
	elif event.is_action_pressed("ui_down") and direction == 3 and inside_area:
		key_pressed = true

func _on_area_entered(area):
	inside_area = true
	key_pressed = false

func _on_area_exited(area):
	if not key_pressed:
		main_script.reduce_life()
	inside_area = false
	key_pressed = false
