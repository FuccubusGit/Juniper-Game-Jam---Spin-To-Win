extends CanvasLayer

@onready var options_menu: Control = $"Options Menu"

func _ready() -> void:
	MusicManager.play_music(preload("res://Audio/727920__ehved__forest-theme-orchestral-loop.mp3"))
	await get_tree().create_timer(0.1).timeout
	prewarm_shaders()
	
func _on_play_button_button_up() -> void:
	FadeManager.transition_to("res://Scenes/intro_cutscene.tscn", preload("res://Audio/Intro music.wav"))


func _on_exit_button_button_up() -> void:
	get_tree().quit()
	
func _on_options_button_button_up() -> void:
	options_menu.visible = true
	

func prewarm_shaders():
	var dummy = Sprite2D.new()
	add_child(dummy)
	
	dummy.material = preload("res://Shaders/Outline.gdshader")
	dummy.material = preload("res://Shaders/Dissolve.tres")
	dummy.material = preload("res://Shaders/Blink.gdshader")
	
	await get_tree().process_frame
	dummy.queue_free()
