extends GPUParticles2D

func _ready():
	one_shot = true

func _on_life_timeout() -> void:
	print("particle death")
	queue_free()
