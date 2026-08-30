class_name BattleDemo
extends Node3D

## Primeiro fluxo jogável de combate para validação da Fase 2.
## Teclas de teste: W/A/S/D, J = ataque, K = especial, L = defesa.

var player: Fighter
var enemy: Fighter
var combat: CombatSystem
var battle: BattleState
var status_label: Label

func _ready() -> void:
	_setup_input()
	combat = CombatSystem.new()
	add_child(combat)
	battle = BattleState.new()
	add_child(battle)
	combat.fighter_defeated.connect(_on_fighter_defeated)
	battle.start_battle()
	_create_status_ui()

func configure(player_fighter: Fighter, enemy_fighter: Fighter) -> void:
	player = player_fighter
	enemy = enemy_fighter

func _physics_process(_delta: float) -> void:
	if player == null or enemy == null or not battle.is_fighting():
		return

	player.is_defending = Input.is_action_pressed("defend")

	if Input.is_action_just_pressed("light_attack"):
		combat.light_attack(player, enemy)
	if Input.is_action_just_pressed("special_attack"):
		combat.special_attack(player, enemy)

	_update_status()

func _setup_input() -> void:
	_add_key_action("light_attack", KEY_J)
	_add_key_action("special_attack", KEY_K)
	_add_key_action("defend", KEY_L)

func _add_key_action(action_name: String, keycode: Key) -> void:
	if not InputMap.has_action(action_name):
		InputMap.add_action(action_name)
	var event := InputEventKey.new()
	event.physical_keycode = keycode
	if not InputMap.action_has_event(action_name, event):
		InputMap.action_add_event(action_name, event)

func _create_status_ui() -> void:
	var layer := CanvasLayer.new()
	layer.name = "BattleHUD"
	add_child(layer)
	status_label = Label.new()
	status_label.position = Vector2(24, 24)
	status_label.add_theme_font_size_override("font_size", 24)
	layer.add_child(status_label)
	_update_status()

func _update_status() -> void:
	if status_label == null:
		return
	if player == null or enemy == null:
		status_label.text = "KYSAM GAME\nPreparando combate..."
		return
	status_label.text = "KYSAM  Vida: %.0f  Energia: %.0f\nINIMIGO  Vida: %.0f\n\nJ: Ataque   K: Especial   L: Defesa" % [player.health, player.energy, enemy.health]

func _on_fighter_defeated(target: Combatant) -> void:
	if target == enemy:
		battle.set_victory()
		status_label.text = "VITÓRIA!\nKysam derrotou o inimigo."
	elif target == player:
		battle.set_defeat()
		status_label.text = "DERROTA!\nKysam foi derrotado."
