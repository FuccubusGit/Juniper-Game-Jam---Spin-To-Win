extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		FadeManager.transition_to("res://Scenes/win_cutscene.tscn", preload("res://Audio/Win Scene.wav"))
