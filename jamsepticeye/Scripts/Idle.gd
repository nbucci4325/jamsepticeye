extends State
class_name EnemyIdle

@export var enemy : CharacterBody2D
@export var wait_time : float = 2.0

var state_name = "Idle"
var time : float
var player : CharacterBody2D

func idling():
	enemy.velocity = Vector2.ZERO

func infect():
	Transitioned.emit(self, 'enemyinfected')

func Enter():
	time = wait_time
	player = get_tree().get_first_node_in_group("Gurt")
	idling()

func Update(delta : float):
	if time > 0:
		time -= delta
		idling()
	else:
		Transitioned.emit(self, 'enemywalk')
	
	var direction = player.global_position - enemy.global_position
	
	if (direction.length() < 160):
		Transitioned.emit(self, 'enemyattack')
