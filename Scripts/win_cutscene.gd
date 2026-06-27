extends CanvasLayer

@onready var animator: AnimatedSprite2D = $AnimatedSprite2D
@onready var button: Button = $Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	await get_tree().create_timer(2).timeout
	animator.play("Win")
	await animator.animation_finished
	button.visible = true
	
	

	
	


func _on_button_button_up() -> void:
	FadeManager.transition_to("res://Scenes/final_scene.tscn", preload("res://Audio/746329__forthell0__calm-lofi-ambient.wav"))
