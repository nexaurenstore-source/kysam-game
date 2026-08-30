class_name CombatAnimationState
extends Node

## Máquina de estados de animação preparada para os modelos reais.
## Não depende de assets: pode ser usada agora com placeholders e depois ligada a AnimationTree/AnimationPlayer.

enum State {
	IDLE,
	WALK,
	RUN,
	ATTACK,
	DEFEND,
	DODGE,
	SPECIAL,
	HIT,
	DEFEAT
}

var current_state: int = State.IDLE
var state_time := 0.0

signal state_changed(previous: int, current: int)

func set_state(new_state: int) -> void:
	if new_state == current_state:
		return
	var previous := current_state
	current_state = new_state
	state_time = 0.0
	state_changed.emit(previous, current_state)

func tick(delta: float) -> void:
	state_time += delta

func state_name() -> String:
	return State.keys()[current_state]

func is_action_state() -> bool:
	return current_state in [State.ATTACK, State.DEFEND, State.DODGE, State.SPECIAL, State.HIT, State.DEFEAT]
