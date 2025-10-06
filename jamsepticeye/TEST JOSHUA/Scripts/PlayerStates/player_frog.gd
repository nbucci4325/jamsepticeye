extends CharacterBody2D

const Shroom = preload("res://TEST JOSHUA/Scenes/Objects/object_mushroom.tscn")

const speed = 120.0

const jump_speed = 300.0
var is_jumping = false
var can_jump = true

var jump_dirX
var jump_dirY

var health = 5

@onready var jump = $Jump
@onready var Infected = $Infected
func _ready():
	Infected.play()

func _physics_process(delta: float) -> void:
	
	if health <= 0:
		abandon_host(position)
	
	
	if Input.is_action_just_pressed("Action"):
		jump.play()
		is_jumping = true
		velocity.x = 0
		velocity.y = 0
		Action()
	
	if !is_jumping:
		var Xdirection := Input.get_axis("LEFT","RIGHT")
		if Xdirection:
			velocity.x = move_toward(velocity.x, (Xdirection * speed), 30)
			jump_dirX = Xdirection
		else:
			velocity.x = move_toward(velocity.x, 0, 15)
			if jump_dirY != 0:
				jump_dirX = 0
		
		var Ydirection := Input.get_axis("UP","DOWN")
		if Ydirection:
			velocity.y = move_toward(velocity.y, (Ydirection * speed), 30)
			jump_dirY = Ydirection
		else:
			velocity.y = move_toward(velocity.y, 0, 15)
			if jump_dirX != 0:
				jump_dirY = 0
	
	move_and_slide()
	
	if Input.is_action_just_pressed("Infect"):
		abandon_host(self.position)

func Action(): #Jump
	await get_tree().create_timer(0.7).timeout
	set_collision_mask_value(4, false) 
	velocity = Vector2(jump_speed * jump_dirX, jump_speed * jump_dirY)
	await get_tree().create_timer(0.5).timeout
	is_jumping = false
	velocity = Vector2(0,0)
	set_collision_mask_value(4, true) 

func abandon_host(position):
	var spore = get_parent().get_node("Player_Gurt")
	spore.position = self.position
	spore.infecting_state = false
	var parent = get_parent()
	var enemy_spawner = get_tree().get_first_node_in_group("enemyFrog")
	enemy_spawner.max += 1
	queue_free()  
	
	var corpse = Shroom.instantiate()
	corpse.position = position
	parent.add_child(corpse)                    


func _on_health_timer_timeout() -> void:
	Deal_damage(1) #Rat does not take timer damage

func Deal_damage(damage):
	health -= damage
