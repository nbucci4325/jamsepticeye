extends Control

class_name credits

@onready var main_menu: Control = %MainMenu

func _on_link_button_pressed() -> void:
	OS.shell_open("res://Assets/Videos/cat-smile.ogv")

func _on_button_pressed() -> void:
	main_menu.emit()
