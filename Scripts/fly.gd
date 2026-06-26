extends Area2D

@onready var timer: Timer = $Timer



func _on_timer_timeout() -> void:
	visible = true
	monitorable = true
	monitoring = true

func disable_area():
	visible = false
	monitorable = false
	monitoring = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("eaten")
		call_deferred("disable_area")
		timer.start()
