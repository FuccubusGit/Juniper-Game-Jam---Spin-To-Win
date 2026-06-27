extends Node2D


@onready var animator: AnimatedSprite2D = $TutorialSprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_tutorial()


func start_tutorial():
	await get_tree().create_timer(5).timeout
	animator.visible = true
	animator.play("default")
	await get_tree().create_timer(10).timeout
	animator.visible = false
	
