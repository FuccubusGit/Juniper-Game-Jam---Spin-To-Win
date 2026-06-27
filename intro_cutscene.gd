extends CanvasLayer

@onready var animator: AnimatedSprite2D = $AnimatedSprite2D
@onready var button: Button = $Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation()
	



func animation():
	await get_tree().create_timer(2.0).timeout
	animator.play("1")
	await animator.animation_finished
	animator.play("2")
	await animator.animation_finished
	animator.play("3")
	await animator.animation_finished
	animator.play("4")
	await animator.animation_finished
	animator.play("5")
	await animator.animation_finished
	button.text = "Continue"
	button.visible = true
	
	

func _on_button_button_up() -> void:
	FadeManager.transition_to("res://Scenes/Test Level.tscn", preload("res://Audio/553953__szegvari__cave_dungeon_secret_temle.wav"))
