extends Control

signal start_game()
signal go_to_credits()

@export var tween_intensity: float
@export var tween_duration: float

@onready var buttons_v_box: VBoxContainer = $MarginContainer/VBoxContainer/ButtonsVBox
@onready var play: Button = $MarginContainer/VBoxContainer/ButtonsVBox/Wrapper1/Play
@onready var credits: Button = $MarginContainer/VBoxContainer/ButtonsVBox/Wrapper2/Credits
@onready var quit: Button = $MarginContainer/VBoxContainer/ButtonsVBox/Control3/Quit

func start_tween(object: Object, property: String, final_val: Variant, duration: float):
	var tween = create_tween()
	tween.tween_property(object, property, final_val, duration)

func btn_hovered(button: Button):
	button.pivot_offset = button.size / 2
	if button.is_hovered():
		start_tween(button, "scale", Vector2.ONE * tween_intensity, tween_duration)
	else:
		start_tween(button, "scale", Vector2.ONE, tween_duration)

func _ready() -> void:
	focus_button()

func _on_play_pressed() -> void:
	start_game.emit()
	hide()
	
func _on_credits_pressed() -> void:
	go_to_credits.emit()

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_visiblity_changed() -> void:
	if visible:
		focus_button()
		
func focus_button() -> void:
	if buttons_v_box:
		var button: Button = buttons_v_box.get_child(0).get_child(0)
		if button is Button:
			button.grab_focus()

func _on_visibility_changed() -> void:
	if visible:
		focus_button()
