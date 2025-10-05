extends VBoxContainer

@export var base_intensity: Vector2 = Vector2(1.2, 1.1)
@export var tween_duration_min: float = 0.3
@export var tween_duration_max: float = 0.6
@export var glow_color: Color = Color(0.7, 1.0, 0.8)
@export var normal_color: Color = Color(1, 1, 1)

var active_tweens := {}

func _ready():
	await get_tree().process_frame
	for child in get_children():
		if child is Button:
			child.modulate = normal_color
			child.mouse_entered.connect(func(): _start_fungal_hover(child))
			child.mouse_exited.connect(func(): _stop_fungal_hover(child))
			
func _stop_fungal_hover(button: Button):
	if active_tweens.has(button):
		active_tweens[button].kill()
		active_tweens.erase(button)
	button.modulate = normal_color

# Start hover pulse and particle emission
func _start_fungal_hover(button: Button):
	if active_tweens.has(button):
		return
	_pulse_step(button)

# Organic pulse step with rotation and glow
func _pulse_step(button: Button):
	if not is_instance_valid(button):
		return
	var tw = create_tween()
	active_tweens[button] = tw

	var duration = randf_range(tween_duration_min, tween_duration_max)

	tw.tween_property(button, "modulate", glow_color, duration / 2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tw.tween_property(button, "modulate", normal_color, duration / 2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	# Continue pulse if still hovered
	tw.finished.connect(func():
		if active_tweens.has(button):
			_pulse_step(button)
	)
