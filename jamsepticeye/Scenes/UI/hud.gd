extends Control

@onready var health_bg: TextureRect = $HealthBG
@onready var health: TextureRect = $HealthBG/Health
@onready var corruption_bg: TextureRect = $CorruptionBG
@onready var corruption: TextureRect = $CorruptionBG/Corruption
@onready var human_counter: Label = $HumanCounter

func update_UI(value):
	if value == 5:
		print("TEST 5")
		health.texture = load("res://Assets/Screens/UI/HUD_Health_Bar05.png")
	if value == 4:
		print("TEST 4")
		health.texture = load("res://Assets/Screens/UI/HUD_Health_Bar04.png")
	if value == 3:
		print("TEST 3")
		health.texture = load("res://Assets/Screens/UI/HUD_Health_Bar03.png")
	if value == 2:
		print("TEST 2")
		health.texture = load("res://Assets/Screens/UI/HUD_Health_Bar02.png")
	if value == 1:
		print("TEST 1")
		health.texture = load("res://Assets/Screens/UI/HUD_Health_Bar01.png")
	#if HumanCounter.kill_human():
		#human_counter.set_text(str(HumanCounter.humans)+"/50")
