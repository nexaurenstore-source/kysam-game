class_name KysamAbilities
extends Node

## Kit de combate de Kysam. A execução visual poderá ser ligada às animações finais.

var rupture := CharacterAbility.new()

func _ready() -> void:
	rupture.ability_name = "Ruptura de Energia"
	rupture.description = "Impacto concentrado da Lâmina de Kysam."
	rupture.energy_cost = 25.0
	rupture.damage_multiplier = 2.5
	rupture.range_bonus = 0.5
	rupture.knockback_multiplier = 1.7
