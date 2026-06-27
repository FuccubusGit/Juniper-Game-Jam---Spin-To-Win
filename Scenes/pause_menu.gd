extends Control

var gamePaused: bool = false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		on_pause_input()
		
func on_pause_input():
	if gamePaused:
		resume_game()
		visible = false
	else:
		pause_game()
		visible = true
		
		
func pause_game():
	Engine.time_scale = 0.0
	get_tree().paused = true
	gamePaused = true
	
func resume_game():
	Engine.time_scale = 1.0
	get_tree().paused = false
	gamePaused = false


func _on_close_menu_button_up() -> void:
	on_pause_input()


func _on_continue_button_button_up() -> void:
	on_pause_input()


func _on_main_menu_button_button_up() -> void:
	on_pause_input()
	FadeManager.transition_to("res://Scenes/main_menu.tscn", preload("res://Audio/727920__ehved__forest-theme-orchestral-loop.mp3"))
