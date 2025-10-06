extends CharacterBody2D

@onready var infection_radius: Area2D = $Infection_Radius

@onready var all_interactions = []
@onready var label: Label = $InteractionComponets/InteractionArea/Label
@onready var gate = get_tree().get_first_node_in_group("Gate")
@onready var death = get_tree().get_first_node_in_group("deathzone")

const Player_Rat = preload("res://TEST JOSHUA/Scenes/PlayerStates/player_rat.tscn")
const Player_Frog = preload("res://TEST JOSHUA/Scenes/PlayerStates/player_frog.tscn")
const Player_Fox = preload("res://TEST JOSHUA/Scenes/PlayerStates/player_fox.tscn")
const Player_Cow = preload("res://TEST JOSHUA/Scenes/PlayerStates/player_cow.tscn")
const Player_Horse = preload("res://TEST JOSHUA/Scenes/PlayerStates/player_horse.tscn")
const Player_Human = preload("res://TEST JOSHUA/Scenes/PlayerStates/player_human.tscn")

const speed = 120.0
var can_infect = 0
var overlap
var infecting_state = false
var infested_player
var gate_exsists = true

func _ready():
	update_interactions()

func _physics_process(delta: float) -> void:
	
	if HealthManager.player_health == 0:
		death.killPlayer()
		HealthManager.refresh_health()
	
	if Input.is_action_just_pressed("Action"):
		execute_interaction()
	
	if !infecting_state:
		var Xdirection := Input.get_axis("LEFT","RIGHT")
		if Xdirection:
			velocity.x = move_toward(velocity.x, (Xdirection * speed), 20)
		else:
			velocity.x = move_toward(velocity.x, 0, 5)
			
		var Ydirection := Input.get_axis("UP","DOWN")
		if Ydirection:
			velocity.y = move_toward(velocity.y, (Ydirection * speed), 20)
		else:
			velocity.y = move_toward(velocity.y, 0, 5)
	
	if infecting_state:
		velocity.y = 0
		velocity.x = 0
	
	move_and_slide()
	
	if can_infect > 0 and Input.is_action_just_pressed("Infect"):
		var nearest_infectable
		var shortest_distance = 10000
		for body in infection_radius.get_overlapping_bodies():
			if body.is_in_group("Infectables"):
				if self.position.distance_to(body.position) < shortest_distance:
					shortest_distance = self.position.distance_to(body.position)
					nearest_infectable = body
		switch_character(choose_infectable(nearest_infectable), nearest_infectable.position)
		nearest_infectable.queue_free()

func switch_character(new_scene: PackedScene, position):
	var infested_player = new_scene.instantiate()
	infested_player.position = position
	var parent = get_parent()
	parent.add_child(infested_player)
	infecting_state = true
	self.position = Vector2(0,0)

func choose_infectable(infectable):
	if infectable.is_in_group("Rats"):
		return Player_Rat
	if infectable.is_in_group("Frogs"):
		return Player_Frog
	if infectable.is_in_group("Foxes"):
		return Player_Fox
	if infectable.is_in_group("Cows"):
		return Player_Cow
	if infectable.is_in_group("Horses"):
		return Player_Horse
	if infectable.is_in_group("Humans"):
		return Player_Human

func _on_infection_radius_body_entered(body: Node2D) -> void:
	if body.is_in_group("Infectables"):
		print("testing")
		print(body)
		can_infect += 1

func _on_infection_radius_body_exited(body: Node2D) -> void:
	if body.is_in_group("Infectables"):
		can_infect -= 1
	
# Nav code - interaction
#################################################

func _on_interaction_area_area_entered(area: Area2D) -> void:
	all_interactions.insert(0, area)
	update_interactions()


func _on_interaction_area_area_exited(area: Area2D) -> void:
	all_interactions.erase(area)
	update_interactions()

func update_interactions():
	if all_interactions:
		label.text = all_interactions[0].interact_label
	else:
		label.text = ""

func execute_interaction():
	if all_interactions:
		var cur_interaction = all_interactions[0]
		match cur_interaction.interact_type:
			"print_text" : print(cur_interaction.interact_value)
			"lever" : delete_gate()

func delete_gate():
	if gate_exsists:
		gate.queue_free()
		gate_exsists = false


func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Humans") or body.is_in_group("Cows"):
		HealthManager.reduce_health()
