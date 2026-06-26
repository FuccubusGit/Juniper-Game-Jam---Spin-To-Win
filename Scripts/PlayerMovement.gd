extends Node

@onready var animator: AnimatedSprite2D = %Animator
@onready var energy: ProgressBar = $"../ProgressBar"


@export var groundSpeed: float
@export var maxGroundSpeed: float
@export var airSpeed: float
@export var maxAirSpeed: float
@export var liftSpeed: float
@export var maxLiftSpeed: float
@export var jumpForce: float
@export	var maxJumpChargeTime: float
@export var downBias: float


var moveDirection = 0
var isCharging: bool = false
var jumpChargeTime = 0
var isFlying: bool = false
var isHurt: bool = false

func _process(delta: float) -> void:
	if isCharging:
		jumpChargeTime += delta
		jumpChargeTime = clampf(jumpChargeTime, 0.0, maxJumpChargeTime)
func set_direction(direction: float):
	moveDirection = direction
	
func move_update(delta):
	if not owner.is_on_floor():
		var target_velocity = moveDirection * airSpeed
		owner.velocity.x = clampf(target_velocity, -maxAirSpeed, maxAirSpeed)
	else:
		owner.velocity.x = 0
	if moveDirection != 0:
		animator.flip_h = moveDirection < 0
	
func start_jump_charge():
	isCharging = true
	
func jump():
	if owner.is_on_floor():
		owner.velocity.y += -jumpForce * jumpChargeTime
		jumpChargeTime = 0
	isCharging = false
	
		
func set_flying(boolean: bool):
	if isHurt or !energy.canFly:
		return
	if owner.velocity.y > 50 or isFlying:
		isFlying = boolean
		
func fly_update(delta):
	if !isFlying or owner.is_on_floor() or isHurt or !energy.canFly:
		return
		
	var acceleration = liftSpeed * delta
	owner.velocity.y = move_toward(owner.velocity.y, -maxLiftSpeed, acceleration)
	owner.velocity.y += downBias * delta
	
func hurt_push(area):
	var delta = get_physics_process_delta_time()
	var push_strength = 7000.0 * delta
	var lift_strength = 20000.0 * delta
	
	var dir_to_target= sign(owner.global_position.x - area.global_position.x)
	
	isFlying = false
	
	owner.velocity = Vector2.ZERO
	owner.velocity.x = lerp(0.0, push_strength * dir_to_target, 1)
	owner.velocity.y = -lift_strength
	
		

func apply_gravity(delta):
	if not owner.is_on_floor():
		if isFlying:
			owner.velocity += owner.get_gravity() * delta * 0.35
			owner.velocity.y = min(owner.velocity.y, 200)
		else:
			owner.velocity += owner.get_gravity() * delta
			owner.velocity.y = min(owner.velocity.y, 650)
