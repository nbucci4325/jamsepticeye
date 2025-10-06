extends Node

signal health_changed(new_value)

var player_health := 5

func _ready():
	print("🩺 HealthManager ready, player_health =", player_health)

func reduce_health():
	player_health -= 1
	print("🩸 HealthManager.reduce_health() ->", player_health)
	emit_signal("health_changed", player_health)

func refresh_health():
	player_health = 5
	emit_signal("health_changed", player_health)
