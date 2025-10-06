extends CharacterBody2D
class_name Horse

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	if velocity == Vector2.ZERO:
		sprite_2d.play("Horse_Walk_Down")
	else:
		if abs(velocity.x) > 5:
			sprite_2d.play("Horse_Walk")
		else:
			if velocity.y > 0:
				sprite_2d.play("Horse_Walk_Down")
			else:
				sprite_2d.play("Horse_Walk_Up")
		
		if velocity.x < 0:
			sprite_2d.flip_h = true
		else:
			sprite_2d.flip_h = false

	move_and_slide()
