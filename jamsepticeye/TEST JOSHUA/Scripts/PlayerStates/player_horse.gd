extends CharacterBody2D 

@onready var destruction_box: Area2D = $DestructionBox

const Shroom = preload("res://TEST JOSHUA/Scenes/Objects/object_mushroom.tscn")

const default_speed = 120.0 #Tweak speed to desired speed
const max_speed = 160.0
var speed = default_speed
var is_running = false

var health = 5
@onready var Dash = $dash
@onready var Walk = $walk
@onready var FenceBreak = $FenceBreak

func _physics_process(delta: float) -> void:
	
	if health <= 0:
		abandon_host(position)
	
	
	if Input.is_action_pressed("Action"):
		Dash.play()
		is_running = true
	
	if Input.is_action_just_released("Action"):
		is_running = false
		speed = default_speed
	
	if is_running && speed < max_speed:
		speed += 1
	
	var Xdirection := Input.get_axis("LEFT","RIGHT")
	if Xdirection:
		Walk.play()
		velocity.x = move_toward(velocity.x, (Xdirection * speed), 30)
	else:
		Walk.play()
		velocity.x = move_toward(velocity.x, 0, 15)
	
	var Ydirection := Input.get_axis("UP","DOWN")
	if Ydirection:
		Walk.play()
		velocity.y = move_toward(velocity.y, (Ydirection * speed), 30)
	else:
		Walk.play()
		velocity.y = move_toward(velocity.y, 0, 15)
	
	move_and_slide()
	
	if is_running && speed == max_speed:
		for area in destruction_box.get_overlapping_areas():
				if area.is_in_group("DestructableFence"):
					FenceBreak.play()
					area.queue_free()
	
	if Input.is_action_just_pressed("Infect"):
		abandon_host(self.position)

func abandon_host(position):
	var spore = get_parent().get_node("Player_Gurt")
	spore.position = self.position
	spore.infecting_state = false
	var parent = get_parent()
	var enemy_spawner = get_tree().get_first_node_in_group("enemyHorse")
	enemy_spawner.max += 1
	queue_free()  
	
	var corpse = Shroom.instantiate()
	corpse.position = position
	parent.add_child(corpse)                    

func _on_health_timers_timeout() -> void:
	Deal_damage(1) #Rat does not take timer damage

func Deal_damage(damage):
	health -= damage
