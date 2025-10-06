extends CharacterBody2D 

const Shroom = preload("res://TEST JOSHUA/Scenes/Objects/object_mushroom.tscn")

@onready var searching_radius: Area2D = $Searching_Radius

const speed = 120.0 #Tweak speed to desired speed
var is_searching = false

var health = 5 # CHANGE THIS

func _physics_process(delta: float) -> void:
	
	if Input.is_action_pressed("Action"):
		is_searching = true
		velocity = Vector2(0,0)
		Action()
		
	if Input.is_action_just_released("Action"):
		is_searching = false
		Revert_action()
	
	if health <= 0:
		abandon_host(position)
	
	if !is_searching:
		var Xdirection := Input.get_axis("LEFT","RIGHT")
		if Xdirection:
			velocity.x = move_toward(velocity.x, (Xdirection * speed), 30)
		else:
			velocity.x = move_toward(velocity.x, 0, 15)
		
		var Ydirection := Input.get_axis("UP","DOWN")
		if Ydirection:
			velocity.y = move_toward(velocity.y, (Ydirection * speed), 30)
		else:
			velocity.y = move_toward(velocity.y, 0, 15)
	
	move_and_slide()
	
	if Input.is_action_just_pressed("Infect"):
		abandon_host(self.position)

func Action(): #search for traps
	for area in searching_radius.get_overlapping_areas():
			if area.is_in_group("Traps"):
				var camo = area.get_child(1)
				camo.set_modulate(Color(1, 1, 1, 0.4))

func Revert_action(): #hide shown traps
	for area in searching_radius.get_overlapping_areas():
			if area.is_in_group("Traps"):
				var camo = area.get_child(1)
				camo.set_modulate(Color(1, 1, 1, 1))


func abandon_host(position):
	var spore = get_parent().get_node("Player_Gurt")
	spore.position = self.position
	spore.infecting_state = false
	var parent = get_parent()
	var enemy_spawner = get_tree().get_first_node_in_group("enemyFox")
	enemy_spawner.max += 1
	Revert_action()
	queue_free()  
	
	var corpse = Shroom.instantiate()
	corpse.position = position
	parent.add_child(corpse)                    


func _on_health_timer_timeout() -> void:
	Deal_damage(1)

func Deal_damage(damage):
	health -= damage
