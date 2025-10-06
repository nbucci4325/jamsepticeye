extends Control

@onready var win: TextureRect = $Win

var increment = 1
func update_win_screen():
	await get_tree().create_timer(5).timeout
	win.texture = load("res://Assets/Screens/Win/Main_EndMenu_Screen0" + str(increment) + ".png")
	increment += 1
