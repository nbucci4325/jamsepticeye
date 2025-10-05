extends CanvasLayer

class_name UI

@onready var main_menu = %MainMenu
@onready var menu = %GameMenu
@onready var transition: ColorRect = %Transition
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var credits_menu: Control = %CreditsMenu
@onready var hud: Control = %HUD

signal start_game()
signal menu_opened()
signal menu_closed()
signal quit_to_menu()
signal credits_menu_opened()
signal credits_menu_closed()

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
	main_menu.show()
	menu.hide()
	credits_menu.hide()
	
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
