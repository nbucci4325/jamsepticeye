extends Area2D

@onready var respawn_point: Marker2D = $RespawnPoint

var checkpoint_manager
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	checkpoint_manager = get_tree().get_first_node_in_group("checkpointManager")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Gurt"):
		checkpoint_manager.last_location = respawn_point.global_position
