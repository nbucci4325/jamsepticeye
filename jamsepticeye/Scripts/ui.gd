extends CanvasLayer

class_name UI

@onready var main_menu = %MainMenu
@onready var menu = %GameMenu
@onready var transition: ColorRect = %Transition
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var credits_menu: Control = %CreditsMenu
@onready var hud: Control = %HUD
@onready var win_screen: Control = %WinScreen

signal start_game()
signal menu_opened()
signal menu_closed()
signal quit_to_menu()
signal credits_menu_opened()
signal credits_menu_closed()
signal update_health

var value = 5

func _on_main_menu_start_game() -> void:
	start_game.emit()
	#transition.show()
	#animation_player.play("screen_transition")
	#await animation_player.animation_finished
	#transition.hide()
	hud.show()

func _input(event):
	if !main_menu.visible and event.is_action_pressed("ui_cancel"):
		menu.visible = !menu.visible
		if menu.visible:
			menu_opened.emit()
			hud.hide()
		else:
			menu_closed.emit()
			hud.show()

func _on_game_menu_main_menu() -> void:
	#if animation_player.is_playing():
		#await animation_player.animation_finished
	menu.hide()
	#transition.show()
	#animation_player.play_backwards("screen_transition")
	#await animation_player.animation_finished
	#transition.hide()
	quit_to_menu.emit()
	main_menu.show()
	
func _on_game_menu_return_to_game() -> void:
	#if animation_player.is_playing():
		#await animation_player.animation_finished
	menu.hide()
	menu_closed.emit()

func _on_go_to_credits() -> void:
	#if animation_player.is_playing():
		#await animation_player.animation_finished
	main_menu.hide()
	menu.hide()
	credits_menu.show()
	credits_menu_opened.emit()
	
func _on_credits_menu_closed() -> void:
	credits_menu.hide()
	main_menu.show()
	credits_menu_closed.emit()

func _ready():
	await get_tree().process_frame  # ensure autoloads are ready
	print("UI _ready() running")

	main_menu.show()
	menu.hide()
	credits_menu.hide()

	# connect to globals
	var health_manager = get_node_or_null("/root/HealthManager")
	var human_counter = get_node_or_null("/root/HumanCounter")

	if human_counter:
		print("UI: found HumanCounter:", human_counter)
		human_counter.connect("humans_changed", Callable(self, "_on_humans_changed"))
		human_counter.connect("win_condition_reached", Callable(self, "_on_win_condition"))
		print("UI: connected to HumanCounter signals")
	else:
		print("⚠️ UI: HumanCounter not found under /root!")



func _on_health_changed(new_value):
	value = new_value
	update_ui()
	
func _on_main_menu_go_to_credits() -> void:
	main_menu.hide()
	menu.hide()
	if animation_player.is_playing():
		await animation_player.animation_finished
	#transition.show()
	#credits_menu_opened.emit()
	#animation_player.play("screen_transition")
	credits_menu.show()
	#await animation_player.animation_finished
	#transition.hide()
	
func _on_credits_menu_return_to_menu() -> void:
	#if animation_player.is_playing():
		#await animation_player.animation_finished
	#transition.show()
	#animation_player.play("screen_transition")
	#await animation_player.animation_finished
	#transition.hide()
	credits_menu.hide()
	main_menu.show()

func win_game():
	hud.hide()
	menu.hide()
	main_menu.hide()
	win_screen.show()

	if HumanCounter.win:
		win_screen.update_win_screen()


func update_ui():
	if HealthManager.player_health == 5:
		value = 5
	if HealthManager.player_health == 4:
		value = 4
	if HealthManager.player_health == 3:
		value = 3
	if HealthManager.player_health == 2:
		value = 2
	if HealthManager.player_health == 1:
		value = 1
	hud.update_UI(value)

func _on_humans_changed(new_value):
	# Update the label inside HUD (hud is the instantiated HUD Control)
	if hud and hud.has_node("HumanCounter"):
		hud.get_node("HumanCounter").text = str(new_value) + "/50"
	else:
		pass
		
func _on_win_condition():
	win_game()
