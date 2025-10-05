extends Area2D

const damage = 10
var is_set = true

func _on_body_entered(body: Node2D) -> void:
	if is_set:
		if body.is_in_group("Player_Controlled_Enemies"):
			body.health -= damage
			is_set = false
		
		elif body.is_in_group("Gurt"):
			HealthManager.reduce_health()
			is_set = false
