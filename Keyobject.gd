extends Area2D

const GRAVITY = 150

var direction = -1  # Dirección de la flecha (debe ser 0, 1, 2, o 3)
var key_pressed = false  # Estado de si la tecla fue presionada correctamente
var inside_area = false  # Estado de si la flecha está dentro del área
var main_script : Node2D  # Para almacenar la referencia a main.gd


func _process(delta):
	position.y += GRAVITY * delta  # Aplica la gravedad a la flecha

	# Si la flecha está dentro del área de contacto y la tecla correcta es presionada
	if inside_area and key_pressed and is_correct_key_pressed():
		queue_free()  # Elimina la flecha cuando la tecla es presionada correctamente


# Función que verifica si la tecla presionada corresponde a la dirección de la flecha
func is_correct_key_pressed():
	match direction:
		0:  # Flecha hacia la izquierda
			if Input.is_action_pressed("ui_left"):
				return true
		1:  # Flecha hacia la derecha
			if Input.is_action_pressed("ui_right"):
				return true
		2:  # Flecha hacia arriba
			if Input.is_action_pressed("ui_up"):
				return true
		3:  # Flecha hacia abajo
			if Input.is_action_pressed("ui_down"):
				return true
		_:
			return false  # Si no tiene dirección asignada, no hace nada

# Método para asignar la rotación aleatoria de la flecha al crearla
func spawn(pos: Vector2, direction: int) -> void:
	position = pos
	self.direction = direction  # Asigna la dirección recibida

	# Asigna la rotación según la dirección
	match direction:
		0:
			rotation_degrees = 0  # Flecha hacia la izquierda
		1:
			rotation_degrees = 180  # Flecha hacia la derecha
		2:
			rotation_degrees = 90  # Flecha hacia arriba
		3:
			rotation_degrees = -90  # Flecha hacia abajo

# Detecta cuando la flecha entra en el área de otra entidad
func _on_area_entered(area):
	inside_area = true  # Marca que la flecha está dentro del área
	key_pressed = false  # Restablece la tecla presionada cuando la flecha entra en el área

# Detecta cuando la flecha sale del área de otra entidad
func _on_area_exited(area):
	if not key_pressed:
		main_script.reduce_life()  # Llama a reduce_life() en main.gd
	inside_area = false  # Marca que la flecha ha salido del área
