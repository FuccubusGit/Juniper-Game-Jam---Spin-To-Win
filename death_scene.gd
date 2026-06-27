extends CanvasLayer

@onready var animator: AnimatedSprite2D = $AnimatedSprite2D2
@onready var button: Button = $Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(1.5).timeout
	start_animation()
	
func start_animation():
	animator.visible = true
	animator.play("1")
	await animator.animation_finished
	animator.play("2")
	await animator.animation_finished
	button.visible = true





func _on_button_button_up() -> void:
	FadeManager.transition_to("res://Scenes/Test Level.tscn", preload("res://Audio/553953__szegvari__cave_dungeon_secret_temle.wav"))
