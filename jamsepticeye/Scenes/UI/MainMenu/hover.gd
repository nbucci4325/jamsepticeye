extends Control

@export var base_intensity: Vector2 = Vector2(1.2, 1.1)
@export var tween_duration_min: float = 0.3
@export var tween_duration_max: float = 0.6
@export var glow_color: Color = Color(0.7, 1.0, 0.8)
@export var normal_color: Color = Color(1, 1, 1)
@export var rotation_range: float = 5.0
@export var neighbor_delay_max: float = 0.2

var active_tweens := {}

func _ready():
	await get_tree().process_frame
	for child in get_children():
		if child is Button:
			child.pivot_offset = child.size / 2
			child.scale = Vector2.ONE
			child.modulate = normal_color
			child.mouse_entered.connect(func(): _start_fungal_hover(child))
			child.mouse_exited.connect(func(): _stop_fungal_hover(child))
			
func _stop_fungal_hover(button: Button):
	if active_tweens.has(button):
		active_tweens[button].kill()
		active_tweens.erase(button)
	button.scale = Vector2.ONE
	button.rotation_degrees = 0
	button.modulate = normal_color

# Start hover pulse and particle emission
func _start_fungal_hover(button: Button):
	if active_tweens.has(button):
		return
	_pulse_step(button)

	# Trigger small neighbor spread
	for neighbor in get_children():
		if neighbor != button and neighbor is Button:
			var delay = randf_range(0.05, neighbor_delay_max)
			async_neighbor_pulse(neighbor, delay)

# Organic pulse step with rotation and glow
func _pulse_step(button: Button):
	if not is_instance_valid(button):
		return
	var tw = create_tween()
	active_tweens[button] = tw

	var random_scale = Vector2(
		randf_range(base_intensity.x * 0.9, base_intensity.x),
		randf_range(base_intensity.y * 0.9, base_intensity.y)
	)
	var random_rotation = randf_range(-rotation_range, rotation_range)
	var duration = randf_range(tween_duration_min, tween_duration_max)

	tw.tween_property(button, "scale", random_scale, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tw.tween_property(button, "rotation_degrees", random_rotation, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tw.tween_property(button, "modulate", glow_color, duration / 2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tw.tween_property(button, "modulate", normal_color, duration / 2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	# Continue pulse if still hovered
	tw.finished.connect(func():
		if active_tweens.has(button):
			_pulse_step(button)
	)

# Optional neighbor pulse for spreading effect
func async_neighbor_pulse(button: Button, delay_time: float) -> void:
	await get_tree().create_timer(delay_time).timeout
	if is_instance_valid(button) and not active_tweens.has(button):
		_pulse_step(button)
