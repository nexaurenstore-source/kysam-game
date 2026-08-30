extends Node3D

## Primeira arena de batalha integrada do Kysam Game.
## Protótipo técnico: Kysam contra um inimigo.

var player: Fighter
var enemy: Fighter
var battle_state: BattleState
var hud: MobileBattleHUD

func _ready() -> void:
	_build_environment()
	_build_arena()
	_create_fighters()
	battle_state = BattleState.new()
	add_child(battle_state)
	battle_state.start_battle()
	_create_hud()

func _build_environment() -> void:
	var world := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.025, 0.03, 0.045)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.65, 0.68, 0.75)
	environment.ambient_light_energy = 0.8
	world.environment = environment
	add_child(world)
	var light := DirectionalLight3D.new()
	light.rotation_degrees = Vector3(-55, -25, 0)
	light.light_energy = 1.3
	light.shadow_enabled = true
	add_child(light)

func _build_arena() -> void:
	var body := StaticBody3D.new()
	body.name = "Arena"
	add_child(body)
	_add_box(body, "Chao", Vector3(18, 0.2, 12), Vector3(0, -0.1, 0))
	_add_box(body, "LimiteNorte", Vector3(18, 2, 0.5), Vector3(0, 1, -6))
	_add_box(body, "LimiteSul", Vector3(18, 2, 0.5), Vector3(0, 1, 6))
	_add_box(body, "LimiteOeste", Vector3(0.5, 2, 12), Vector3(-9, 1, 0))
	_add_box(body, "LimiteLeste", Vector3(0.5, 2, 12), Vector3(9, 1, 0))

func _add_box(parent: Node3D, node_name: String, size: Vector3, position: Vector3) -> void:
	var part := StaticBody3D.new()
	part.name = node_name
	part.position = position
	parent.add_child(part)
	var mesh := MeshInstance3D.new()
	var box_mesh := BoxMesh.new()
	box_mesh.size = size
	mesh.mesh = box_mesh
	part.add_child(mesh)
	var collision := CollisionShape3D.new()
	var box_shape := BoxShape3D.new()
	box_shape.size = size
	collision.shape = box_shape
	part.add_child(collision)

func _create_fighters() -> void:
	player = _create_fighter("Kysam", Vector3(-3, 0, 0), KysamProfile.new())
	var enemy_profile := CharacterProfile.new()
	enemy_profile.character_name = "Inimigo"
	enemy_profile.max_health = 70
	enemy_profile.max_energy = 50
	enemy_profile.attack_power = 7
	enemy = _create_fighter("Inimigo", Vector3(3, 0, 0), enemy_profile)

func _create_fighter(fighter_name: String, fighter_position: Vector3, profile: CharacterProfile) -> Fighter:
	var fighter := Fighter.new()
	fighter.name = fighter_name
	fighter.position = fighter_position
	fighter.profile = profile
	fighter.health = profile.max_health
	fighter.energy = profile.max_energy
	add_child(fighter)
	var mesh := MeshInstance3D.new()
	var capsule := CapsuleMesh.new()
	capsule.radius = 0.5
	capsule.height = 2.0
	mesh.mesh = capsule
	mesh.position.y = 1.0
	fighter.add_child(mesh)
	var collision := CollisionShape3D.new()
	var shape := CapsuleShape3D.new()
	shape.radius = 0.5
	shape.height = 2.0
	collision.shape = shape
	collision.position.y = 1.0
	fighter.add_child(collision)
	return fighter

func _create_hud() -> void:
	hud = MobileBattleHUD.new()
	hud.name = "BattleHUD"
	add_child(hud)
	hud.setup(player, enemy, battle_state)
