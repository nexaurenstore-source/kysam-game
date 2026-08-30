class_name CharacterAbility
extends Resource

## Dados de uma habilidade única. A execução visual será ligada às animações posteriormente.

@export var ability_name := ""
@export var description := ""
@export var energy_cost := 25.0
@export var damage_multiplier := 2.0
@export var range_bonus := 0.0
@export var knockback_multiplier := 1.0

func can_use(current_energy: float) -> bool:
	return current_energy >= energy_cost

func get_damage(base_damage: float) -> float:
	return base_damage * damage_multiplier
