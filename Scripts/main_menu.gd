extends CanvasLayer


func _ready() -> void:
	MusicManager.play_music(preload("res://Audio/727920__ehved__forest-theme-orchestral-loop.mp3"))

func _on_play_button_button_up() -> void:
	FadeManager.transition_to("res://Scenes/Test Level.tscn")


func _on_exit_button_button_up() -> void:
	get_tree().quit()
