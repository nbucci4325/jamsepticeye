extends Control

@onready var buttons_v_box: VBoxContainer = $MarginContainer/VBoxContainer/ButtonsVBox

signal start_game()

func _ready() -> void:
	focus_button()

func _on_play_pressed() -> void:
	start_game.emit()
	hide()

func _on_settings_pressed() -> void:
	pass # Replace with function body.

func _on_credits_pressed() -> void:
	pass # Replace with function body.

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_visiblity_changed() -> void:
	if visible:
		focus_button()
		
func focus_button() -> void:
	if buttons_v_box:
		var button: Button = buttons_v_box.get_child(0)
		if button is Button:
			button.grab_focus()

func _on_visibility_changed() -> void:
	if visible:
		focus_button()
