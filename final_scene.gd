extends CanvasLayer

@onready var button: Button = $Button

func _ready() -> void:
	await get_tree().create_timer(5).timeout
	button.visible = true


func _on_button_button_up() -> void:
	FadeManager.transition_to("res://Scenes/main_menu.tscn", preload("res://Audio/727920__ehved__forest-theme-orchestral-loop.mp3"))
