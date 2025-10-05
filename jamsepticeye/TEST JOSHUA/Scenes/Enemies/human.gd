extends CharacterBody2D
class_name Human

func _physics_process(delta: float) -> void:

	move_and_slide()

func dead():
	queue_free()
