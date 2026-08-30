class_name BattleState
extends Node

## Estados básicos de uma luta.

enum State {
	READY,
	FIGHTING,
	VICTORY,
	DEFEAT
}

var state: State = State.READY

signal battle_started
signal victory
signal defeat

func start_battle() -> void:
	state = State.FIGHTING
	battle_started.emit()

func set_victory() -> void:
	if state == State.FIGHTING:
		state = State.VICTORY
		victory.emit()

func set_defeat() -> void:
	if state == State.FIGHTING:
		state = State.DEFEAT
		defeat.emit()

func is_fighting() -> bool:
	return state == State.FIGHTING
