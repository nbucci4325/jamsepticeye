extends Node

signal humans_changed(new_value)
signal win_condition_reached

var humans: int = 5
var win: bool = false

func _ready():
	set_process(true)

func _process(_delta):
	if humans == 0 and !win:
		win = true
		emit_signal("win_condition_reached")

func kill_human():
	if humans <= 0:
		return
	humans -= 1
	emit_signal("humans_changed", humans)
