extends Node

var humans : int = 50
var win = false

func _process(float):
	print(win)
	if humans == 0:
		win = true

func kill_human():
	humans -= 1
