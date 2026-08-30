class_name Combatant
extends CharacterBody3D

## Base para qualquer lutador.
## O sistema será compartilhado por Kysam, Elian e futuros personagens.

@export var profile: CharacterProfile

var health: float = 100.0
var energy: float = 100.0
var is_defending := false
var is_dodging := false
var can_attack := true

func setup(character_profile: CharacterProfile) -> void:
	profile = character_profile
	health = profile.max_health
	energy = profile.max_energy

func receive_damage(amount: float) -> void:
	var damage := amount
	if is_defending and profile:
		damage *= max(0.1, 1.0 - profile.defense_power / 100.0)
	health = max(0.0, health - damage)
	if health <= 0.0:
		die()

func spend_energy(amount: float) -> bool:
	if energy < amount:
		return false
	energy -= amount
	return true

func restore_energy(amount: float) -> void:
	energy = min(profile.max_energy if profile else 100.0, energy + amount)

func die() -> void:
	set_physics_process(false)
	set_process(false)
