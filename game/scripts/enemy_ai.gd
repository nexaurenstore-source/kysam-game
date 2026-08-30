class_name EnemyAI
extends Fighter

## IA mínima para o primeiro inimigo.
## Aproxima-se do jogador e ataca quando entra no alcance.

@export var target_path: NodePath
@export var chase_speed := 3.0
@export var attack_distance := 1.8

var target: Combatant

func _ready() -> void:
	if not target_path.is_empty():
		target = get_node_or_null(target_path) as Combatant

func set_target(new_target: Combatant) -> void:
	target = new_target

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if target == null or health <= 0.0:
		velocity = Vector3.ZERO
		return

	var direction := target.global_position - global_position
	direction.y = 0.0
	var distance := direction.length()

	if distance > attack_distance:
		velocity = direction.normalized() * chase_speed
		move_and_slide()
	else:
		velocity = Vector3.ZERO
		try_light_attack(target)
