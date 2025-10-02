extends Node2D

class_name Game

const LevelScene = preload("res://Scenes/level.tscn")

func start_game():
	var level = LevelScene.instantiate()
	add_child(level)
	move_child(level, 0)
	
func _on_ui_start_game() -> void:
	start_game()
	
