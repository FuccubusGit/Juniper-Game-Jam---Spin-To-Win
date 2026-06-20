extends Node

@onready var animator: AnimatedSprite2D = %Animator

@export var groundSpeed: float
@export var maxGroundSpeed: float
@export var airSpeed: float
@export var maxAirSpeed: float
@export var liftSpeed: float
@export var maxLiftSpeed: float
@export var jumpForce: float

var moveDirection = 0
var isFlying: bool = false


func set_direction(direction: float):
	moveDirection = direction
	
func move_update(delta):
	if not owner.is_on_floor():
		var target_velocity = moveDirection * airSpeed
		owner.velocity.x = clampf(target_velocity, -maxAirSpeed, maxAirSpeed)
	else:  
		owner.velocity.x = moveDirection
	
	if moveDirection != 0:
		animator.flip_h = moveDirection < 0
	

func jump():
	if owner.is_on_floor():
		print("Trying Jump")
		owner.velocity.y += -jumpForce
		
func set_flying(boolean: bool):
	if owner.velocity.y > 0 or isFlying:
		isFlying = boolean
		
func fly_update(delta):
	if !isFlying or owner.is_on_floor():
		return
		
	var acceleration = liftSpeed * delta
	owner.velocity.y = move_toward(owner.velocity.y, -maxLiftSpeed, acceleration)
	owner.velocity.y += 180 * delta
	print (owner.velocity.y)
		

func apply_gravity(delta):
	
	if not owner.is_on_floor():
		if isFlying:
			owner.velocity += owner.get_gravity() * delta * 0.35
			owner.velocity.y = min(owner.velocity.y, 200)
		else:
			owner.velocity += owner.get_gravity() * delta
			owner.velocity.y = min(owner.velocity.y, 650)
