extends Area2D

var player
var checkpoint_manager
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Gurt")
	checkpoint_manager = get_tree().get_first_node_in_group("checkpointManager")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Gurt"):
		killPlayer()
	if body.is_in_group("sploosh"):
		audio_stream_player_2d.play()

func killPlayer():
	player.position = checkpoint_manager.last_location
