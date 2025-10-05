extends Control

signal start_game()
signal go_to_credits()

@export var tween_intensity: float
@export var tween_duration: float

@onready var buttons_v_box: VBoxContainer = $MarginContainer/VBoxContainer/ButtonsVBox
@onready var play: Button = $MarginContainer/VBoxContainer/ButtonsVBox/Wrapper1/Play
@onready var credits: Button = $MarginContainer/VBoxContainer/ButtonsVBox/Wrapper2/Credits
@onready var quit: Button = $MarginContainer/VBoxContainer/ButtonsVBox/Control3/Quit

@onready var MenuMusic = $MainMenuMusic
@onready var Click = $ButtonClick

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
	MenuMusic.play()

func _on_play_pressed() -> void:
	Click.play()
	start_game.emit()
	hide()
	MenuMusic.stop()
	
func _on_credits_pressed() -> void:
	Click.play()
	go_to_credits.emit()

func _on_quit_pressed() -> void:
	Click.play()
	await get_tree().create_timer(1).timeout
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
