extends Node

signal health_changed(new_value)

var player_health = 5

func _ready():
	player_health = 5

func refresh_health():
	player_health = 5

func reduce_health():
	player_health -= 1
	print(player_health)
	emit_signal("health_changed", player_health)
