extends CharacterBody2D 

const Shroom = preload("res://TEST JOSHUA/Scenes/Objects/object_mushroom.tscn")
@onready var infection_radius: Area2D = $"Infection Radius"

const speed = 120.0 #Tweak speed to desired speed

var health = 5

func _ready() -> void:
	infection_radius.set_process_mode(Node.PROCESS_MODE_DISABLED)

func _physics_process(delta: float) -> void:
	
	if health <= 0:
		abandon_host(position)
	
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
	
	if Input.is_action_just_pressed("Action"):
		Action()
	
	if Input.is_action_just_pressed("Infect"):
		abandon_host(self.position)

func Action():
	infection_radius.set_process_mode(Node.PROCESS_MODE_INHERIT)
	await get_tree().create_timer(2).timeout
	infection_radius.set_process_mode(Node.PROCESS_MODE_DISABLED)

func abandon_host(position):
	var spore = get_parent().get_node("Player_Gurt")
	spore.position = self.position
	spore.infecting_state = false
	var parent = get_parent()
	queue_free()  
					 

	var corpse = Shroom.instantiate()
	corpse.position = position
	parent.add_child(corpse)   

func _on_infection_radius_body_entered(body: Node2D) -> void:
	if body.is_in_group("Humans"):
		if body.state.state_name != "Infected":
			body.state.infect()


func _on_health_timer_timeout() -> void:
	Deal_damage(1) 

func Deal_damage(damage):
	health -= damage
