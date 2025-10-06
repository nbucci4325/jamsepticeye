extends Control

@onready var win: TextureRect = $Win

var increment := 1
var counter := 1

func update_win_screen():
	while counter < 3:
		win.texture = load("res://Assets/Screens/Win/Main_EndMenu_Screen0" + str(increment) + ".png")
		increment += 1
		counter += 1
		await get_tree().create_timer(3).timeout
	
	# Show final image (if you have one more)
	win.texture = load("res://Assets/Screens/Win/Main_EndMenu_Screen03.png")

	# Wait a few seconds so the player sees the final image
	await get_tree().create_timer(3).timeout

	# ❌ Force quit the entire game
	get_tree().quit()
