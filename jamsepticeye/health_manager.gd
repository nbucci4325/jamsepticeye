extends Node

var player_health = 5

func _ready():
	player_health = 5

func reduce_health():
	player_health -= 1
	return player_health

func refresh_health():
	player_health = 5
