class_name MobileControls
extends CanvasLayer

## Controles touch iniciais para Android.
## Os mesmos sinais podem ser ligados ao controlador de movimento e combate.

signal move_input(value: Vector2)
signal attack_pressed
signal defend_pressed
signal dodge_pressed
signal special_pressed

var joystick_center := Vector2(110, 610)
var joystick_radius := 70.0
var joystick_active := false
var joystick_touch := -1

func _ready() -> void:
	_create_button("ATAQUE", Vector2(1080, 570), attack_pressed)
	_create_button("DEFESA", Vector2(930, 650), defend_pressed)
	_create_button("ESQUIVA", Vector2(930, 500), dodge_pressed)
	_create_button("ESPECIAL", Vector2(1080, 690), special_pressed)

func _create_button(text: String, position: Vector2, pressed_signal: Signal) -> void:
	var button := Button.new()
	button.text = text
	button.position = position - Vector2(65, 32)
	button.size = Vector2(130, 64)
	button.add_theme_font_size_override("font_size", 18)
	button.pressed.connect(func(): pressed_signal.emit())
	add_child(button)

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed and event.position.distance_to(joystick_center) <= joystick_radius * 1.5:
			joystick_active = true
			joystick_touch = event.index
			_emit_joystick(event.position)
		elif not event.pressed and event.index == joystick_touch:
			joystick_active = false
			joystick_touch = -1
			move_input.emit(Vector2.ZERO)
	elif event is InputEventScreenDrag and event.index == joystick_touch and joystick_active:
		_emit_joystick(event.position)

func _emit_joystick(position: Vector2) -> void:
	var offset := position - joystick_center
	if offset.length() > joystick_radius:
		offset = offset.normalized() * joystick_radius
	move_input.emit(offset / joystick_radius)
