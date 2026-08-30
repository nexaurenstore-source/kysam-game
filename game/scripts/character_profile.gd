class_name CharacterProfile
extends Resource

## Base de dados para personagens do Kysam Game.
## Cada personagem poderá ter estilo, arma especial e poder único.

@export var character_name: String = "Kysam"
@export var max_health: float = 100.0
@export var max_energy: float = 100.0
@export var attack_power: float = 10.0
@export var defense_power: float = 5.0
@export var move_speed: float = 5.0
@export var weapon_name: String = "Arma Especial"
@export var weapon_description: String = "Arma exclusiva do personagem."
@export var unique_power_name: String = "Poder Único"
@export var unique_power_description: String = "Habilidade exclusiva do personagem."
