class_name MobileBattleHUD
extends CanvasLayer

## HUD de combate e ponte entre controles touch e o lutador.

var player: Fighter
var enemy: Fighter
var battle_state: BattleState
var status_label: Label
var player_health: ProgressBar
var player_energy: ProgressBar
var enemy_health: ProgressBar
var dodge_timer := 0.0
var defending := false

func setup(new_player: Fighter, new_enemy: Fighter, new_state: BattleState) -> void:
	player = new_player
	enemy = new_enemy
	battle_state = new_state
	_create_hud()

func _process(delta: float) -> void:
	dodge_timer = max(0.0, dodge_timer - delta)
	if player:
		player_health.value = player.health
		player_energy.value = player.energy
	if enemy:
		enemy_health.value = enemy.health

func _create_hud() -> void:
	status_label = Label.new()
	status_label.position = Vector2(40, 25)
	status_label.text = "KYSAM GAME — LUTA"
	status_label.add_theme_font_size_override("font_size", 28)
	add_child(status_label)

	player_health = _bar(Vector2(40, 75), 100.0)
	player_energy = _bar(Vector2(40, 120), 100.0)
	enemy_health = _bar(Vector2(900, 75), 70.0)

	var controls := MobileControls.new()
	controls.name = "MobileControls"
	add_child(controls)
	controls.attack_pressed.connect(_attack)
	controls.defend_pressed.connect(_defend)
	controls.dodge_pressed.connect(_dodge)
	controls.special_pressed.connect(_special)

func _bar(position: Vector2, maximum: float) -> ProgressBar:
	var bar := ProgressBar.new()
	bar.position = position
	bar.size = Vector2(320, 30)
	bar.max_value = maximum
	bar.value = maximum
	bar.show_percentage = false
	add_child(bar)
	return bar

func _attack() -> void:
	if player and enemy and battle_state and battle_state.is_fighting():
		if player.try_light_attack(enemy):
			status_label.text = "ATAQUE!"

func _special() -> void:
	if player and enemy and battle_state and battle_state.is_fighting():
		if player.try_special(enemy):
			status_label.text = "PODER ESPECIAL!"

func _defend() -> void:
	if player:
		defending = not defending
		player.is_defending = defending
		status_label.text = "DEFESA ATIVA" if defending else "DEFESA DESATIVADA"

func _dodge() -> void:
	if player == null or dodge_timer > 0.0 or not battle_state.is_fighting():
		return
	if not player.spend_energy(10.0):
		return
	dodge_timer = 0.8
	player.is_dodging = true
	var direction := -player.global_transform.basis.z
	direction.y = 0.0
	player.velocity += direction.normalized() * 7.0
	status_label.text = "ESQUIVA!"
	await get_tree().create_timer(0.25).timeout
	if is_instance_valid(player):
		player.is_dodging = false
