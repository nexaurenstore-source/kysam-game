extends Node3D

## Fundação da arena de combate.
## Cria chão e quatro limites físicos simples para o protótipo.

@export var arena_size := Vector2(18.0, 12.0)
@export var wall_height := 2.0
@export var wall_thickness := 0.5

func _ready() -> void:
	_create_floor()
	_create_walls()

func _create_floor() -> void:
	var floor_body := StaticBody3D.new()
	floor_body.name = "Chao"
	add_child(floor_body)

	var mesh := MeshInstance3D.new()
	var box := BoxMesh.new()
	box.size = Vector3(arena_size.x, 0.2, arena_size.y)
	mesh.mesh = box
	floor_body.add_child(mesh)

	var collision := CollisionShape3D.new()
	var shape := BoxShape3D.new()
	shape.size = Vector3(arena_size.x, 0.2, arena_size.y)
	collision.shape = shape
	floor_body.add_child(collision)

func _create_walls() -> void:
	_create_wall("LimiteNorte", Vector3(0, wall_height / 2.0, -arena_size.y / 2.0), Vector3(arena_size.x, wall_height, wall_thickness))
	_create_wall("LimiteSul", Vector3(0, wall_height / 2.0, arena_size.y / 2.0), Vector3(arena_size.x, wall_height, wall_thickness))
	_create_wall("LimiteOeste", Vector3(-arena_size.x / 2.0, wall_height / 2.0, 0), Vector3(wall_thickness, wall_height, arena_size.y))
	_create_wall("LimiteLeste", Vector3(arena_size.x / 2.0, wall_height / 2.0, 0), Vector3(wall_thickness, wall_height, arena_size.y))

func _create_wall(wall_name: String, wall_position: Vector3, wall_size: Vector3) -> void:
	var body := StaticBody3D.new()
	body.name = wall_name
	body.position = wall_position
	add_child(body)

	var mesh := MeshInstance3D.new()
	var box := BoxMesh.new()
	box.size = wall_size
	mesh.mesh = box
	body.add_child(mesh)

	var collision := CollisionShape3D.new()
	var shape := BoxShape3D.new()
	shape.size = wall_size
	collision.shape = shape
	body.add_child(collision)
