extends CharacterBody2D 

const Shroom = preload("res://TEST JOSHUA/Scenes/Objects/object_mushroom.tscn")

const speed = 120.0 #Tweak speed to desired speed

func _physics_process(delta: float) -> void:
	
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

func Action(): #Human thingy?
	pass

func abandon_host(position):
	var spore = get_parent().get_node("Player_Gurt")
	spore.position = self.position
	spore.infecting_state = false
	var parent = get_parent()
	queue_free()  
	
	var corpse = Shroom.instantiate()
	corpse.position = position
	parent.add_child(corpse)                    


func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
