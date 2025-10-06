extends Area2D

const damage = 10
var is_set = true
@onready var BearTrap = $BearTrap

func _on_body_entered(body: Node2D) -> void:
	if is_set:
		if body.is_in_group("Player_Controlled_Enemies"):
			BearTrap.play()
			body.health -= damage
			is_set = false
		
		elif body.is_in_group("Gurt"):
			BearTrap.play()
			HealthManager.reduce_health()
			is_set = false
