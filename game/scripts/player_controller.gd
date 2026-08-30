extends CharacterBody3D

## Kysam — controlador inicial da Fundação.
## Movimento simples; combate e controles touch entram nas próximas fases.

@export var move_speed: float = 5.0

func _physics_process(_delta: float) -> void:
	var input_vector := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := Vector3(input_vector.x, 0.0, input_vector.y)
	velocity.x = direction.x * move_speed
	velocity.z = direction.z * move_speed
	move_and_slide()
