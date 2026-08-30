extends CharacterBody3D

## Kysam — controlador de movimento da Fundação.
## O combate e os controles touch serão adicionados nas próximas fases.

@export var move_speed: float = 5.0

func _physics_process(_delta: float) -> void:
	var input_vector := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := Vector3(input_vector.x, 0.0, input_vector.y)

	if direction.length_squared() > 1.0:
		direction = direction.normalized()

	velocity.x = direction.x * move_speed
	velocity.z = direction.z * move_speed
	velocity.y = 0.0

	move_and_slide()
