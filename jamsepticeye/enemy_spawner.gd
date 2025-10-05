extends Node

@export var enemy_prefab : PackedScene
@export var max : int = 3

func _on_timer_timeout() -> void:
	if max > 0:
		var enemy = enemy_prefab.instantiate()
		add_child(enemy)
		max -= 1
