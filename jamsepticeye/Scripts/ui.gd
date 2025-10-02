extends CanvasLayer

class_name UI

@onready var main_menu = %MainMenu

signal start_game()

func _on_main_menu_start_game() -> void:
	start_game.emit()
