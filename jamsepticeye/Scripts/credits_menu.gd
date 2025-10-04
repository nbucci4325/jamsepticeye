extends Control

signal return_to_menu()

func _on_return_pressed() -> void:
	return_to_menu.emit()
