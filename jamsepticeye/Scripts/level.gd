extends Node2D

@onready var CaveMusic = $CaveArea/Cave
@onready var ForestMusic = $ForestArea/Forest
@onready var FarmMusic = $FarmArea/Farm
@onready var TownMusic = $TownArea/Town




func _on_cave_area_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Gurt")):
		CaveMusic.play()

func _on_cave_area_body_exited(body: Node2D) -> void:
	if(body.is_in_group("Gurt")):
		CaveMusic.stop()


func _on_forest_area_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Gurt")):
		ForestMusic.play()

func _on_forest_area_body_exited(body: Node2D) -> void:
	if(body.is_in_group("Gurt")):
		ForestMusic.stop()


func _on_farm_area_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Gurt")):
		FarmMusic.play()

func _on_farm_area_body_exited(body: Node2D) -> void:
	if(body.is_in_group("Gurt")):
		FarmMusic.stop()


func _on_town_area_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Gurt")):
		TownMusic.play()


func _on_town_area_body_exited(body: Node2D) -> void:
	if(body.is_in_group("Gurt")):
		TownMusic.stop()
