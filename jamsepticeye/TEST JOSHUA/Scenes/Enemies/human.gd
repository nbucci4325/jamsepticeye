extends CharacterBody2D
class_name Human

@onready var state_machine: Node = $StateMachine

func _physics_process(delta: float) -> void:

	move_and_slide()

func dead():
	queue_free()
