extends Button





func _on_button_up() -> void:
	FadeManager.transition_to("res://Scenes/win_cutscene.tscn", preload("res://Audio/Win Scene.wav"))
