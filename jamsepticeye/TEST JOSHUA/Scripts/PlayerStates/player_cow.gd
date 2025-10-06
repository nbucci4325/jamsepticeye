extends CharacterBody2D

const Shroom = preload("res://TEST JOSHUA/Scenes/Objects/object_mushroom.tscn")
@onready var anim: AnimatedSprite2D = $Sprite2D

const speed = 120.0

var health = 5
@onready var Walk = $Walk
@onready var Infected = $Infected

func _ready():
	Infected.play()

func _physics_process(delta: float) -> void:
	
	if health <= 0:
		abandon_host(position)
	
	var cam = get_tree().get_first_node_in_group("Cam")
	cam.position = self.position
	
	var Xdirection := Input.get_axis("LEFT","RIGHT")
	if Xdirection:
		Walk.play()
		velocity.x = move_toward(velocity.x, (Xdirection * speed), 50)
		if Xdirection == 1:
			anim.play("WALK_RIGHT")
		if Xdirection == -1:
			anim.play("WALK_LEFT")
	else:
		Walk.play()
		velocity.x = move_toward(velocity.x, 0, 5)
	
	var Ydirection := Input.get_axis("UP","DOWN")
	if Ydirection:
		Walk.play()
		velocity.y = move_toward(velocity.y, (Ydirection * speed), 50)
		if !Xdirection:
			if Ydirection == 1:
				anim.play("UP")
			if Ydirection == -1:
				anim.play("DOWN")
	else:
		Walk.play()
		velocity.y = move_toward(velocity.y, 0, 5)
		if !Xdirection && !Ydirection:
				anim.play("UP")
	
	move_and_slide()
	
	if Input.is_action_just_pressed("Infect"):
		abandon_host(self.position)

func abandon_host(position):
	var spore = get_parent().get_node("Player_Gurt")
	spore.position = self.position
	spore.infecting_state = false
	var parent = get_parent()
	var enemy_spawner = get_tree().get_first_node_in_group("enemyCow")
	#enemy_spawner.max += 1
	queue_free()  
	
	var corpse = Shroom.instantiate()
	corpse.position = position
	parent.add_child(corpse)                    


func _on_health_timer_timeout() -> void:
	Deal_damage(1) 

func Deal_damage(damage):
	health -= damage
