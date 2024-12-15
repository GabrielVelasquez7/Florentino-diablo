extends Area2D

@export var GRAVITY = 0
@export var INITIAL_LIVES = 3  # Número inicial de vidas

var inside_area = false
var direction = -1  # -1 como valor predeterminado para la dirección
var lives = INITIAL_LIVES  # Inicializa las vidas

# Definir una señal para notificar al Catcher cuando la tecla correcta sea presionada
signal key_pressed_correctly(direction)

# Referencia al AnimationPlayer del Catcher 1 (ya que solo tienes uno)
var catcher_animation_player: AnimationPlayer = null

func _ready():
	# Asignamos el AnimationPlayer solo para el Catcher 1
	catcher_animation_player = get_node_or_null("$Objects/Catcher/Sprite2D/AnimationPlayer")
	
	# Muestra las vidas iniciales
	print("Vidas iniciales: ", lives)

func _process(delta):
	position.y += GRAVITY * delta  # Aplica la gravedad a la flecha

	# Si la flecha está dentro del área de contacto
	if inside_area:
		# Verificamos si la tecla correcta está presionada para la dirección
		if is_correct_key_pressed():
			# Solo intentamos reproducir la animación si la dirección es 0 (Catcher 1)
			if direction == 0 and catcher_animation_player:
				catcher_animation_player.play("change_color")  # Reproduce la animación
			queue_free()  # Elimina la flecha cuando la tecla es presionada

# Función que verifica si la tecla presionada corresponde a la dirección de la flecha
func is_correct_key_pressed():
	match direction:
		0:  # Flecha hacia la izquierda (Catcher 1)
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
	inside_area = true


# Detecta cuando la flecha sale del área de otra entidad
func _on_area_exited(area):
	inside_area = false
	lives -= 1
	
	# Aquí restamos una vida si no se presionó la tecla correcta
	if !is_correct_key_pressed():
		
		print("¡Te equivocaste! Vidas restantes: ", lives)
		
		# Verifica si las vidas llegaron a 0
		if lives <= 0:
			print("¡Has perdido! Juego terminado.")
			# Aquí puedes agregar código para terminar el juego o reiniciarlo.
			# Por ejemplo, podrías emitir una señal o llamar a algún método para finalizar el juego.
