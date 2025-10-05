extends CharacterBody2D
class_name Human

@onready var state_machine: Node = $StateMachine

var state

func _ready():
	state = state_machine.current_state

func _physics_process(delta: float) -> void:
	state = state_machine.current_state
	move_and_slide()

func dead():
	queue_free()
