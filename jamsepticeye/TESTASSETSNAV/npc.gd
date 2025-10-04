extends CharacterBody2D
class_name Enemy

@onready var animation_player_2: AnimationPlayer = $AnimationPlayer2

func _physics_process(delta: float) -> void:
	move_and_slide()
	
	if (abs(velocity.x) > 50):
		if (velocity.x > 0):
			animation_player_2.play("move_right")
		else:
			animation_player_2.play("move_left")
	else:
		if (velocity.y > 0):
			animation_player_2.play("move_down")
		else:
			animation_player_2.play("move_up")
