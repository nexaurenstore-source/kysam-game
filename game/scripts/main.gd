extends Node3D

## Kysam Game — Fundação da Fase 1.
## Cria uma arena 3D simples, limites físicos, jogador de teste e câmera.

const ARENA_SIZE := Vector2(18.0, 12.0)

func _ready() -> void:
	_setup_input()
	_build_environment()
	_build_arena()
	_build_player()
	_build_camera()
	print("Kysam Game — Fundação iniciada")

func _setup_input() -> void:
	_add_key_action("move_left", KEY_A)
	_add_key_action("move_right", KEY_D)
	_add_key_action("move_forward", KEY_W)
	_add_key_action("move_back", KEY_S)

func _add_key_action(action_name: String, keycode: Key) -> void:
	if not InputMap.has_action(action_name):
		InputMap.add_action(action_name)
	var event := InputEventKey.new()
	event.physical_keycode = keycode
	if not InputMap.action_has_event(action_name, event):
		InputMap.action_add_event(action_name, event)

func _build_environment() -> void:
	var world := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.035, 0.045, 0.06)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.55, 0.6, 0.7)
	environment.ambient_light_energy = 0.7
	world.environment = environment
	add_child(world)

	var light := DirectionalLight3D.new()
	light.rotation_degrees = Vector3(-55.0, -30.0, 0.0)
	light.light_energy = 1.2
	light.shadow_enabled = true
	add_child(light)

func _build_arena() -> void:
	var arena := Node3D.new()
	arena.name = "Arena"
	add_child(arena)

	var ground := StaticBody3D.new()
	ground.name = "Ground"
	arena.add_child(ground)

	var ground_mesh := MeshInstance3D.new()
	var ground_shape := CollisionShape3D.new()
	var box_mesh := BoxMesh.new()
	box_mesh.size = Vector3(ARENA_SIZE.x, 0.2, ARENA_SIZE.y)
	ground_mesh.mesh = box_mesh
	var box_shape := BoxShape3D.new()
	box_shape.size = Vector3(ARENA_SIZE.x, 0.2, ARENA_SIZE.y)
	ground_shape.shape = box_shape
	ground.add_child(ground_mesh)
	ground.add_child(ground_shape)

	var wall_thickness := 0.5
	_build_wall(arena, "WallNorth", Vector3(0, 1, -ARENA_SIZE.y / 2.0), Vector3(ARENA_SIZE.x, 2, wall_thickness))
	_build_wall(arena, "WallSouth", Vector3(0, 1, ARENA_SIZE.y / 2.0), Vector3(ARENA_SIZE.x, 2, wall_thickness))
	_build_wall(arena, "WallWest", Vector3(-ARENA_SIZE.x / 2.0, 1, 0), Vector3(wall_thickness, 2, ARENA_SIZE.y))
	_build_wall(arena, "WallEast", Vector3(ARENA_SIZE.x / 2.0, 1, 0), Vector3(wall_thickness, 2, ARENA_SIZE.y))

func _build_wall(parent: Node3D, wall_name: String, wall_position: Vector3, wall_size: Vector3) -> void:
	var wall := StaticBody3D.new()
	wall.name = wall_name
	wall.position = wall_position
	parent.add_child(wall)
	var mesh := MeshInstance3D.new()
	var shape := CollisionShape3D.new()
	var box_mesh := BoxMesh.new()
	box_mesh.size = wall_size
	mesh.mesh = box_mesh
	var box_shape := BoxShape3D.new()
	box_shape.size = wall_size
	shape.shape = box_shape
	wall.add_child(mesh)
	wall.add_child(shape)

func _build_player() -> void:
	var player := get_node_or_null("Player") as CharacterBody3D
	if player == null:
		player = CharacterBody3D.new()
		player.name = "Player"
		player.position = Vector3(0, 1.0, 2.5)
		add_child(player)

	var collision := CollisionShape3D.new()
	var capsule := CapsuleShape3D.new()
	capsule.radius = 0.45
	capsule.height = 1.8
	collision.shape = capsule
	collision.position.y = 0.9
	player.add_child(collision)

	var mesh := MeshInstance3D.new()
	var capsule_mesh := CapsuleMesh.new()
	capsule_mesh.radius = 0.45
	capsule_mesh.height = 1.8
	mesh.mesh = capsule_mesh
	mesh.position.y = 0.9
	player.add_child(mesh)

	var script := load("res://game/scripts/player_controller.gd") as Script
	player.set_script(script)

func _build_camera() -> void:
	var camera := get_node_or_null("Camera") as Camera3D
	if camera == null:
		camera = Camera3D.new()
		camera.name = "Camera"
		add_child(camera)
	camera.position = Vector3(0, 7.0, 10.0)
	camera.rotation_degrees = Vector3(-28.0, 0.0, 0.0)
	camera.current = true
