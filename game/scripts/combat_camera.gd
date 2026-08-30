class_name CombatCamera
extends Camera3D

## Câmera dinâmica para combate 3D.
## Mantém o jogador e o adversário enquadrados sem permitir que a câmera atravesse a arena.

@export var player_path: NodePath
@export var enemy_path: NodePath
@export var follow_height := 4.0
@export var follow_distance := 7.5
@export var smooth_speed := 6.0
@export var look_height := 1.2

var player: Node3D
var enemy: Node3D

func _ready() -> void:
	player = get_node_or_null(player_path)
	enemy = get_node_or_null(enemy_path)
	current = true

func setup(new_player: Node3D, new_enemy: Node3D) -> void:
	player = new_player
	enemy = new_enemy
	current = true

func _process(delta: float) -> void:
	if player == null or enemy == null:
		return

	var midpoint := (player.global_position + enemy.global_position) * 0.5
	var separation := player.global_position.distance_to(enemy.global_position)
	var distance := clamp(follow_distance + separation * 0.45, 6.0, 11.0)
	var direction := player.global_position - enemy.global_position
	direction.y = 0.0
	if direction.length_squared() < 0.01:
		direction = Vector3(0, 0, 1)
	direction = direction.normalized()

	var target_position := midpoint + direction * distance
	target_position.y = midpoint.y + follow_height
	global_position = global_position.lerp(target_position, 1.0 - exp(-smooth_speed * delta))
	look_at(midpoint + Vector3.UP * look_height, Vector3.UP)
