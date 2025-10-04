extends Node2D

class_name Game

const LevelScene = preload("res://Scenes/level.tscn")
@onready var GameMusic = $MenuMusic


var current_level: Node = null

func _ready() -> void:
	GameMusic.play()

func start_game():
	current_level = LevelScene.instantiate()
	add_child(current_level)
	move_child(current_level, 0)
	get_tree().paused = false
	
func _on_ui_start_game() -> void:
	start_game()
	GameMusic.stop()
	
	
func _on_ui_quit_to_menu() -> void:
	if current_level:
		current_level.queue_free()
		current_level = null
	

func _on_ui_menu_closed() -> void:
	get_tree().paused = false


func _on_ui_menu_opened() -> void:
	get_tree().paused = true
	
