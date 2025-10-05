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




func _on_cave_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Gurt"):
		CaveBG.play()
		CaveWD.play()
		CaveFire.play()
		print("Entered")

func _on_cave_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Gurt"):
		CaveBG.stop()
		CaveWD.stop()
		CaveFire.stop()
		print("Exited")

func _on_forest_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Gurt"):
		ForestBG.play()
		ForestBirds.play()
		print("Entered")

func _on_forest_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Gurt"):
		ForestBG.stop()
		ForestBirds.stop()
		print("Exited")

func _on_farm_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Gurt"):
		FarmBG.play()
		FarmMoos.play()
		print("Entered")

func _on_farm_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Gurt"):
		FarmBG.stop()
		FarmMoos.stop()
		print("Exited")

func _on_town_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Gurt"):
		TownBG.play()
		TownTalking.play()
		print("Entered")

func _on_town_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Gurt"):
		TownBG.stop()
		TownTalking.stop()
		print("Exited")
