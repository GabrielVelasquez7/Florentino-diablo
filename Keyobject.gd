extends Area2D

@export var GRAVITY = 100
var inside_area = false
var direction = -1
var key_pressed = false
var Mundo_script: Node2D  # Referencia al script principal

func _process(delta):
	position.y += GRAVITY * delta

# Esta función es para comprobar si la tecla presionada es la correcta
func is_correct_key_pressed() -> bool:
	var key_map = {
		0: "ui_left",
		1: "ui_right",
		2: "ui_up",
		3: "ui_down"
	}
	return Input.is_action_just_pressed(key_map.get(direction, ""))

func _input(event):
	# Solo se procesa la entrada si está dentro del área y no se ha presionado la tecla correcta
	if inside_area and not key_pressed:
		if is_correct_key_pressed():
			key_pressed = true
			Mundo_script.increase_score()  # Llama a la función increase_score() en main.gd
			queue_free()  # Elimina la flecha correctamente


func _on_area_entered(area):
	# Marca que la flecha está dentro del área
	if area != self:
		inside_area = true
		key_pressed = false

func _on_area_exited(area):
	# Solo resta una vida si no se presionó la tecla correcta
	if area != self and not key_pressed and inside_area:
		Mundo_script.reduce_life()  # Llama a reduce_life cuando el área sale y la tecla no fue presionada
	inside_area = false
	key_pressed = false
