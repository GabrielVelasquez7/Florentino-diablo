extends Area2D

@export var GRAVITY = 0
@export var INITIAL_LIVES = 3  # Número inicial de vidas

var inside_area = false
var direction = -1  # Dirección de la flecha (-1 como predeterminado)
var lives = INITIAL_LIVES  # Inicializa las vidas
var key_pressed = false  # Estado de si la tecla fue presionada correctamente
var Mundo_script : Node2D  # Referencia al script principal (main.gd)
var catcher_animation_player: AnimationPlayer = null  # Referencia al AnimationPlayer del Catcher

# Definir una señal para notificar cuando la tecla correcta sea presionada
signal key_pressed_correctly(direction)

func _ready():
	# Asignamos el AnimationPlayer del Catcher 1
	catcher_animation_player = get_node_or_null("$Objects/Catcher/Sprite2D/AnimationPlayer")
	# Asignamos el script principal
	Mundo_script = get_parent()  # Ajusta según la jerarquía

func _process(delta):
	position.y += GRAVITY * delta  # Aplica la gravedad a la flecha

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
	match direction:
		0:
			rotation_degrees = 0  # Flecha hacia la izquierda
		1:
			rotation_degrees = 180  # Flecha hacia la derecha
		2:
			rotation_degrees = 90  # Flecha hacia arriba
		3:
			rotation_degrees = -90  # Flecha hacia abajo

func _on_area_entered(area):
	inside_area = true  # Marca que la flecha está dentro del área
	key_pressed = false  # Restablece la tecla presionada

func _on_area_exited(area):
	# Reduce la vida si la flecha no fue correctamente manejada
	if inside_area and not key_pressed:
		Mundo_script.reduce_life()
	inside_area = false  # Marca que la flecha ha salido del área
