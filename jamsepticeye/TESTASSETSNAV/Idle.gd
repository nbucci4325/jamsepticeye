extends State
class_name EnemyIdle

@export var enemy : CharacterBody2D
@export var wait_time : float = 2.0

var time : float

func idling():
	enemy.rotate(PI/90)

func Enter():
	time = wait_time
	idling()

func Update(delta : float):
	if time > 0:
		time -= delta
		idling()
	else:
		Transitioned.emit(self, 'enemywalk')
