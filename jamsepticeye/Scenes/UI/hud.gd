extends Control

@onready var health_bg: TextureRect = $HealthBG
@onready var health: TextureRect = $HealthBG/Health
@onready var corruption_bg: TextureRect = $CorruptionBG
@onready var corruption: TextureRect = $CorruptionBG/Corruption

var decrement = 5

func update_UI():
	if HealthManager.reduce_health():
		health.texture = load("res://Assets/Screens/UI/HUD_Health_Bar0" + str(decrement) + ".png")
		decrement -= 1
