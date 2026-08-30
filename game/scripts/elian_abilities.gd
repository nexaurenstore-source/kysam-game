class_name ElianAbilities
extends Node

## Kit de combate de Elian.

var lightning_dance := CharacterAbility.new()

func _ready() -> void:
	lightning_dance.ability_name = "Dança Relâmpago"
	lightning_dance.description = "Avanço veloz com as Lâminas Gêmeas de Elian."
	lightning_dance.energy_cost = 25.0
	lightning_dance.damage_multiplier = 2.0
	lightning_dance.range_bonus = 2.0
	lightning_dance.knockback_multiplier = 0.8
