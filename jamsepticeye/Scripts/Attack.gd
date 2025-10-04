extends State
class_name EnemyAttack

@export var enemy : CharacterBody2D
@export var move_speed :float = 10.0

var player : CharacterBody2D

func Enter():
	player = get_tree().get_first_node_in_group("Gurt")

func Physics_Update(delta: float):
	var direction = player.global_position - enemy.global_position
	
	if direction.length() < 150:
		enemy.velocity = direction.normalized() * move_speed
	else:
		enemy.velocity = Vector2.ZERO
	
	if direction.length() > 200:
		Transitioned.emit(self, 'enemyidle')
