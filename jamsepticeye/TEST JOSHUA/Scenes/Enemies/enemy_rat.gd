extends CharacterBody2D
class_name Rate

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	if velocity == Vector2.ZERO:
		sprite_2d.play("Rat_Walk_Down")
	else:
		if abs(velocity.x) > 5:
			sprite_2d.play("Rat_Walk")
		else:
			if velocity.y > 0:
				sprite_2d.play("Rat_Walk_Down")
			else:
				sprite_2d.play("Rat_Walk_Up")

		if velocity.x < 0:
			sprite_2d.flip_h = false
		else:
			sprite_2d.flip_h = true
	move_and_slide()
