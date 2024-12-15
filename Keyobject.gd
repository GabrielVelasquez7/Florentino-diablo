extends Area2D

@export var GRAVITY = 0
@export var INITIAL_LIVES = 3  # Número inicial de vidas

var inside_area = false
var direction = -1  # Dirección de la flecha (-1 como predeterminado)
var lives = INITIAL_LIVES  # Inicializa las vidas
var key_pressed = false  # Estado de si la tecla fue presionada correctamente
var Mundo_script : Node2D  # Referencia al script principal (main.gd)
var catcher_animation_player: AnimationPlayer = null  # Referencia al AnimationPlayer del Catcher
var main_script : Node2D  # Para almacenar la referencia a main.gd

# Definir una señal para notificar cuando la tecla correcta sea presionada
signal key_pressed_correctly(direction)

func _ready():
	# Asignamos el AnimationPlayer del Catcher 1
	catcher_animation_player = get_node_or_null("$Objects/Catcher/Sprite2D/AnimationPlayer")
	# Asignamos el script principal
	Mundo_script = get_parent()  # Ajusta según la jerarquía



func _process(delta):
	position.y += GRAVITY * delta


	# Verifica si la flecha está dentro del área y la tecla correcta fue presionada
	if inside_area and is_correct_key_pressed():
		emit_signal("key_pressed_correctly", direction)  # Emite señal
		if direction == 0 and catcher_animation_player:
			catcher_animation_player.play("change_color")  # Reproduce la animación
		queue_free()  # Elimina la flecha

func is_correct_key_pressed() -> bool:
	# Mapea direcciones a las acciones correspondientes
	var key_map = {
		0: "ui_left",
		1: "ui_right",
		2: "ui_up",
		3: "ui_down"
	}
	return Input.is_action_pressed(key_map.get(direction, ""))

func spawn(pos: Vector2, direction: int) -> void:
	position = pos
	self.direction = direction  # Asigna la dirección recibida

	# Define la rotación según la dirección

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

	inside_area = true  # Marca que la flecha está dentro del área
	key_pressed = false  # Restablece la tecla presionada

func _on_area_exited(area):
	# Reduce la vida si la flecha no fue correctamente manejada
	if inside_area and not key_pressed:
		Mundo_script.reduce_life()
	inside_area = false  # Marca que la flecha ha salido del área

	inside_area = true
	key_pressed = false

func _on_area_exited(area):
	if not key_pressed:
		main_script.reduce_life()
	inside_area = false
	key_pressed = false

