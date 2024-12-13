extends Area2D

const GRAVITY = 150

var inside_area = false
var direction = -1  # -1 como valor predeterminado para la dirección

func _process(delta):
	position.y += GRAVITY * delta  # Aplica la gravedad a la flecha

	# Si la flecha está dentro del área de contacto
	if inside_area:
		# Verificamos si la tecla correcta está presionada para la dirección
		if is_correct_key_pressed():
			print("debug=> tecla correcta presionada, eliminando flecha!")
			queue_free()  # Elimina la flecha cuando la tecla es presionada

# Función que verifica si la tecla presionada corresponde a la dirección de la flecha
func is_correct_key_pressed():
	match direction:
		0:  # Flecha hacia la izquierda
			if Input.is_action_pressed("ui_left"):
				print("debug=> Flecha hacia la izquierda y tecla izquierda presionada")
				return true
		1:  # Flecha hacia la derecha
			if Input.is_action_pressed("ui_right"):
				print("debug=> Flecha hacia la derecha y tecla derecha presionada")
				return true
		2:  # Flecha hacia arriba
			if Input.is_action_pressed("ui_up"):
				print("debug=> Flecha hacia arriba y tecla arriba presionada")
				return true
		3:  # Flecha hacia abajo
			if Input.is_action_pressed("ui_down"):
				print("debug=> Flecha hacia abajo y tecla abajo presionada")
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

	# Asegura que la flecha tenga la rotación correcta


# Detecta cuando la flecha entra en el área de otra entidad
func _on_area_entered(area):
	inside_area = true


# Detecta cuando la flecha sale del área de otra entidad
func _on_area_exited(area):
	inside_area = false
