extends Node

@onready var animator: AnimatedSprite2D = %Animator
@onready var energy: ProgressBar = $"../ProgressBar"
@onready var jump_particles: GPUParticles2D = $"../Jump Particles"


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
var isTweenRunning: bool = false
var isHardLanding: bool = false
var canInput: bool = true

var fallTimer: float = 0

func _process(delta: float) -> void:
	if owner.velocity.y > 300:
		fallTimer += delta
	if fallTimer > 0.3:
		isHardLanding = true
		if owner.is_on_floor() and isHardLanding:
			await get_tree().create_timer(1.0).timeout
			isHardLanding = false
			fallTimer = 0.0
			canInput = false
	if not canInput:
		await get_tree().create_timer(0.6).timeout
		canInput = true
	if isCharging and canInput:
		jumpChargeTime += delta
		jumpChargeTime = clampf(jumpChargeTime, 0.0, maxJumpChargeTime)
	if jumpChargeTime == maxJumpChargeTime and not isTweenRunning:
		isTweenRunning = true
		animator.material.set_shader_parameter("blink_color", Color.WHITE)
		var tween = get_tree().create_tween()
		tween.tween_method(owner.SetShader_BlinkIntensity, 1.0, 0.0, 0.5)
		await tween.finished
		isTweenRunning = false
		
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
	if canInput:
		isCharging = true
	
func jump():
	if owner.is_on_floor():
		if jumpChargeTime == maxJumpChargeTime:
			jump_particles.restart()
			jump_particles.emitting = true
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
