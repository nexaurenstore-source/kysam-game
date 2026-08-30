class_name CombatSystem
extends Node

## Sistema mínimo de combate da Fase 2.
## Mantém ataque, defesa, dano e estados de vitória/derrota separados do visual.

signal damage_dealt(target: Combatant, amount: float)
signal fighter_defeated(target: Combatant)

@export var light_attack_damage := 10.0
@export var light_attack_cost := 0.0
@export var special_attack_damage := 25.0
@export var special_attack_cost := 25.0

func light_attack(attacker: Combatant, target: Combatant) -> bool:
	if attacker == null or target == null or not attacker.can_attack:
		return false
	if not attacker.spend_energy(light_attack_cost):
		return false
	_apply_damage(attacker, target, light_attack_damage)
	return true

func special_attack(attacker: Combatant, target: Combatant) -> bool:
	if attacker == null or target == null or not attacker.can_attack:
		return false
	if not attacker.spend_energy(special_attack_cost):
		return false
	_apply_damage(attacker, target, special_attack_damage)
	return true

func set_defending(fighter: Combatant, defending: bool) -> void:
	if fighter:
		fighter.is_defending = defending

func _apply_damage(_attacker: Combatant, target: Combatant, amount: float) -> void:
	var before := target.health
	target.receive_damage(amount)
	var actual_damage := before - target.health
	damage_dealt.emit(target, actual_damage)
	if target.health <= 0.0:
		fighter_defeated.emit(target)
