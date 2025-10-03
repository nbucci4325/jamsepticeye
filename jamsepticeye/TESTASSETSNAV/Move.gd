extends CharacterBody2D

@export var top_left: Marker2D
@export var bottom_right: Marker2D

var speed = 100
var target_position
var direction

func awake():
	set_new_target_position()

func set_new_target_position():
	var random_offset_x = randf_range(top_left.position.x, bottom_right.position.x)
	var random_offset_y = randf_range(top_left.position.y, bottom_right.position.y)
	target_position = Vector2(random_offset_x, random_offset_y)

func _physics_process(delta: float): 
	if (randi() % 50 == 1):
		set_new_target_position()
		direction = (target_position - global_position).normalized()
		velocity = direction * speed
	move_and_slide()
