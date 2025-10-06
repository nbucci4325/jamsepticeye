extends Node2D

@onready var CaveBG = $CaveArea/CaveMusic
@onready var CaveWD = $CaveArea/CaveWaterD
@onready var CaveFire = $CaveArea/CaveFire


@onready var ForestBG = $ForestArea/ForestMusic
@onready var ForestBirds = $ForestArea/ForestBirds


@onready var FarmBG = $FarmArea/FarmMusic
@onready var FarmMoos = $FarmArea/FarmCows

@onready var TownBG = $TownArea/TownMusic
@onready var TownTalking = $TownArea/TownTalking



func _on_cave_area_area_entered(area: Area2D) -> void:
	if (area.name == "Playerpos"):
		CaveBG.play()
		CaveWD.play()
		CaveFire.play()
		print("Entered")


func _on_cave_area_area_exited(area: Area2D) -> void:
	if (area.name == "Playerpos"):
		CaveBG.stop()
		CaveWD.stop()
		CaveFire.stop()
		print("Exited")


func _on_forest_area_area_entered(area: Area2D) -> void:
	if (area.name == "Playerpos"):
		ForestBG.play()
		ForestBirds.play()
		print("Entered")

func _on_forest_area_area_exited(area: Area2D) -> void:
	if (area.name == "Playerpos"):
		ForestBG.stop()
		ForestBirds.stop()
		print("Exited")


func _on_farm_area_area_entered(area: Area2D) -> void:
	if (area.name == "Playerpos"):
		FarmBG.play()
		FarmMoos.play()
		print("Entered")

func _on_farm_area_area_exited(area: Area2D) -> void:
	if (area.name == "Playerpos"):
		FarmBG.stop()
		FarmMoos.stop()
		print("Exited")

func _on_town_area_area_entered(area: Area2D) -> void:
	if (area.name == "Playerpos"):
		TownBG.play()
		TownTalking.play()
		print("Entered")

func _on_town_area_area_exited(area: Area2D) -> void:
	if (area.name == "Playerpos"):
		TownBG.stop()
		TownTalking.stop()
		print("Exited")
