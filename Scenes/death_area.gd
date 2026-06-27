extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		FadeManager.transition_to("res://Scenes/death_scene.tscn", preload("res://Audio/530217__sondredrakensson__do-robots-get-bored.mp3"))
