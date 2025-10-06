extends Area2D

const damage = 10
var is_set = true
@onready var Crossbow = $Crossbow

func _on_body_entered(body: Node2D) -> void:
	if is_set:
		if body.is_in_group("Player_Controlled_Enemies"):
			Crossbow.play()
			body.health -= damage
			is_set = false
		
		elif body.is_in_group("Gurt"):
			Crossbow.play()
			HealthManager.reduce_health()
			is_set = false
