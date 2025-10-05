extends State
class_name EnemyInfected

@onready var sprite_2d: Sprite2D = $"../../Sprite2D"
@export var enemy : CharacterBody2D
@export var move_speed := 10.0
@export var death_timer := 10.0

var state_name = "Infected"
var player : CharacterBody2D
var move_direction : Vector2
var wander_time : float

func randomize_wander():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(4, 7)

func Enter():
	sprite_2d.set_modulate(Color(1, 0, 1, 1))
	randomize_wander()

func Update(delta: float):
	if wander_time > 0:
		wander_time -= delta
	
	else:
		randomize_wander()
	
	if death_timer > 0:
		death_timer -= delta
	elif death_timer <=0 :
		enemy.dead()


func Physics_Update(delta: float):
	if enemy:
		enemy.velocity = move_direction * move_speed
