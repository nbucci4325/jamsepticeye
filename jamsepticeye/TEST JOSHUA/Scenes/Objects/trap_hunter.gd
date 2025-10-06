extends Area2D

@onready var camo: Sprite2D = $Camo
@onready var trap: AnimatedSprite2D = $Trap

const damage = 10
var is_set = true
@onready var BearTrap = $BearTrap

func _on_body_entered(body: Node2D) -> void:
	if is_set:
		if body.is_in_group("Player_Controlled_Enemies"):
<<<<<<< HEAD
			BearTrap.play()
=======
			trap.play("Closed")
			camo.hide()
>>>>>>> ecc3d01256e1b6dc4121ed213b26c4fdcbf2661f
			body.health -= damage
			is_set = false
		
		elif body.is_in_group("Gurt"):
<<<<<<< HEAD
			BearTrap.play()
=======
			trap.play("Closed")
			camo.hide()
>>>>>>> ecc3d01256e1b6dc4121ed213b26c4fdcbf2661f
			HealthManager.reduce_health()
			is_set = false
