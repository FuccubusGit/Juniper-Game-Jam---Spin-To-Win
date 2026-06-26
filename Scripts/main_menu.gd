extends CanvasLayer




func _on_play_button_button_up() -> void:
	FadeManager.transition_to("res://Scenes/Test Level.tscn")


func _on_exit_button_button_up() -> void:
	get_tree().quit()
