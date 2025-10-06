extends Node

var humans : int = 50
var win = false

func _process(float):
	if humans == 0:
		win = true

func kill_human():
	humans -= 1
