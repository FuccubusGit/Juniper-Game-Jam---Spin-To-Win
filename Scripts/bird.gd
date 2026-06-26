extends CharacterBody2D

@onready var ray: RayCast2D = $RayCast2D
@onready var animator: AnimatedSprite2D = $AnimatedSprite2D

@export var speed: float

var moveDirection = 1

func _physics_process(delta: float) -> void:
	if ray.is_colliding():
		moveDirection *= -1
		animator.flip_h = moveDirection < 0
		ray.target_position.x *= -1
		
	velocity.x = moveDirection * speed * delta
	
	move_and_slide()
		
		
		
	
