extends CharacterBody2D
class_name Human2

@onready var state_machine: Node = $StateMachine
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

var state

func _ready():
	state = state_machine.current_state
	

func _physics_process(delta: float) -> void:
	state = state_machine.current_state
	
	if velocity == Vector2.ZERO:
		sprite_2d.play("Human_M_Walk_Down")
	else:
		if abs(velocity.x) > 5:
			sprite_2d.play("Human_M_Walk")
		else:
			if velocity.y > 0:
				sprite_2d.play("Human_M_Walk_Down")
			else:
				sprite_2d.play("Human_M_Walk_Up")
		
		if velocity.x < 0:
			sprite_2d.flip_h = false
		else:
			sprite_2d.flip_h = true
	
	move_and_slide()

func dead():
	queue_free()
