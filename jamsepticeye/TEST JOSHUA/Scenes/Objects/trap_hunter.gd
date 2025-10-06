extends Area2D

@onready var camo: Sprite2D = $Camo
@onready var trap: AnimatedSprite2D = $Trap

const damage = 10
var is_set = true

func _on_body_entered(body: Node2D) -> void:
	if is_set:
		if body.is_in_group("Player_Controlled_Enemies"):
			trap.play("Closed")
			camo.hide()
			body.health -= damage
			is_set = false
		
		elif body.is_in_group("Gurt"):
			trap.play("Closed")
			camo.hide()
			HealthManager.reduce_health()
			is_set = false
