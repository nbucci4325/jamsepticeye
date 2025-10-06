extends Control

@onready var health_bg: TextureRect = $HealthBG
@onready var health: TextureRect = $HealthBG/Health
@onready var corruption_bg: TextureRect = $CorruptionBG
@onready var corruption: TextureRect = $CorruptionBG/Corruption
@onready var human_counter: Label = $HumanCounter

func _ready():
	var human_counter_global = get_node_or_null("/root/HumanCounter")
	if human_counter_global:
		human_counter_global.connect("humans_changed", Callable(self, "_on_humans_changed"))
		human_counter.text = str(human_counter_global.humans) + "/50"
	else:
		pass


func update_UI(value):
	if value == 5:
		health.texture = load("res://Assets/Screens/UI/HUD_Health_Bar05.png")
	if value == 4:
		health.texture = load("res://Assets/Screens/UI/HUD_Health_Bar04.png")
	if value == 3:
		health.texture = load("res://Assets/Screens/UI/HUD_Health_Bar03.png")
	if value == 2:
		health.texture = load("res://Assets/Screens/UI/HUD_Health_Bar02.png")
	if value == 1:
		health.texture = load("res://Assets/Screens/UI/HUD_Health_Bar01.png")
	#if HumanCounter.kill_human():
		#human_counter.set_text(str(HumanCounter.humans)+"/50")

func _on_humans_changed(new_value):
	human_counter.text = str(new_value) + "/50"
