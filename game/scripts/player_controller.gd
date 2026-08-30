extends CharacterBody3D

## Kysam — movimento para teclado e touch.

@export var move_speed: float = 5.0
var touch_direction := Vector2.ZERO

func _ready() -> void:
	var controls := get_node_or_null("../MobileControls")
	if controls:
		controls.move_input.connect(_on_touch_move)

func _physics_process(_delta: float) -> void:
	var input_vector := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	if touch_direction.length_squared() > 0.001:
		input_vector = touch_direction

	var direction := Vector3(input_vector.x, 0.0, input_vector.y)
	if direction.length_squared() > 1.0:
		direction = direction.normalized()

	velocity.x = direction.x * move_speed
	velocity.z = direction.z * move_speed
	if not is_on_floor():
		velocity.y -= 20.0 * _delta
	else:
		velocity.y = 0.0

	move_and_slide()

func _on_touch_move(value: Vector2) -> void:
	touch_direction = value
