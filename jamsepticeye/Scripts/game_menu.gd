extends Control

signal return_to_game()
signal main_menu()

@export var tween_intensity: float
@export var tween_duration: float

@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")
@onready var buttons_v_box: VBoxContainer = %ButtonsVBox
@onready var rtgButton: Button = $MarginContainer/ButtonsVBox/ReturnToGame
@onready var mmButton: Button = $MarginContainer/ButtonsVBox/MainMenu
@onready var qButton: Button = $MarginContainer/ButtonsVBox/Quit

func start_tween(object: Object, property: String, final_val: Variant, duration: float):
	var tween = create_tween()
	tween.tween_property(object, property, final_val, duration)

func btn_hovered(button: Button):
	button.pivot_offset = button.size / 2
	if button.is_hovered():
		start_tween(button, "scale", Vector2.ONE * tween_intensity, tween_duration)
	else:
		start_tween(button, "scale", Vector2.ONE, tween_duration)

func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(MUSIC_BUS_ID, value < .05)
	
func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(SFX_BUS_ID, value < .05)

func focus_button() -> void:
	if buttons_v_box:
		var button: Button = buttons_v_box.get_child(0)
		if button is Button:
			button.grab_focus()

func _on_visibility_changed() -> void:
	if visible:
		focus_button()


func _on_return_to_game_pressed() -> void:
	return_to_game.emit()


func _on_main_menu_pressed() -> void:
	main_menu.emit()


func _on_quit_pressed() -> void:
	get_tree().quit()
