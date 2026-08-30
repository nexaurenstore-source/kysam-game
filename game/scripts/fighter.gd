class_name Fighter
extends Combatant

## Lutador base do Kysam Game.
## Movimento, orientação, defesa e ataques são reutilizáveis por todos os personagens.

@export var attack_range := 2.0
@export var attack_cooldown := 0.35
@export var knockback_force := 3.0
@export var move_speed := 5.0

var attack_timer := 0.0
var move_input := Vector2.ZERO

func _physics_process(delta: float) -> void:
	attack_timer = max(0.0, attack_timer - delta)
	if not is_dodging:
		velocity.x = move_input.x * move_speed
		velocity.z = move_input.y * move_speed
		if move_input.length_squared() > 0.01:
			var look_direction := Vector3(move_input.x, 0.0, move_input.y)
			look_at(global_position + look_direction, Vector3.UP)
	if not is_on_floor():
		velocity.y -= 20.0 * delta
	else:
		velocity.y = 0.0
	move_and_slide()

func set_move_input(value: Vector2) -> void:
	move_input = value.limit_length(1.0)

func try_light_attack(target: Combatant) -> bool:
	if attack_timer > 0.0 or target == null or is_dodging:
		return false
	if global_position.distance_to(target.global_position) > attack_range:
		return false
	attack_timer = attack_cooldown
	target.receive_damage(profile.attack_power if profile else 10.0)
	_apply_knockback(target)
	return true

func try_special(target: Combatant) -> bool:
	if attack_timer > 0.0 or target == null or is_dodging:
		return false
	if global_position.distance_to(target.global_position) > attack_range + 0.5:
		return false
	if not spend_energy(25.0):
		return false
	attack_timer = attack_cooldown * 1.5
	target.receive_damage((profile.attack_power if profile else 10.0) * 2.5)
	_apply_knockback(target, knockback_force * 1.7)
	return true

func _apply_knockback(target: Combatant, force: float = knockback_force) -> void:
	var direction := target.global_position - global_position
	direction.y = 0.0
	if direction.length_squared() > 0.001:
		direction = direction.normalized()
		target.velocity.x = direction.x * force
		target.velocity.z = direction.z * force
