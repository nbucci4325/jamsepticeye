extends Node

@export var enemy_prefab : PackedScene
@export var max : int = 0
@export var group = ''

func _ready() -> void:
	add_to_group(group)

func _on_timer_timeout() -> void:
	if max > 0:
		var enemy = enemy_prefab.instantiate()
		add_child(enemy)
		max -= 1
