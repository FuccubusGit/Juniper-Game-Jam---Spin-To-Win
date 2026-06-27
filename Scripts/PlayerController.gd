extends CharacterBody2D

@onready var move: Node = $MovementComponent
@onready var flightBar: ProgressBar = $ProgressBar
@onready var animator: AnimatedSprite2D = %Animator
@onready var camera: Camera2D = $Camera2D
@onready var hurt_particles: GPUParticles2D = $"Hurt Particles"
@onready var hit_sound: AudioStreamPlayer2D = $Audio/HitSound
@onready var power_up: AudioStreamPlayer2D = $Audio/PowerUpSound




var cameraShakeNoise: FastNoiseLite
var fallTimer: float = 0
var isStart: bool = true



func _ready() -> void:
	cameraShakeNoise = FastNoiseLite.new()
	
	InputBus.move_input.connect(on_move_input)
	InputBus.jump_input.connect(on_jump_input)
	InputBus.jump_input_released.connect(on_jump_released)
	InputBus.fly_input_pressed.connect(on_fly_input_pressed)
	InputBus.fly_input_released.connect(on_fly_input_released)
	InputBus.grapple_input.connect(on_grapple_input)
	
	
	
func _physics_process(delta: float) -> void:
	move_and_slide()
	move.apply_gravity(delta)
	
	if isStart and is_on_floor():
		start_camera()
	
	if move.isHurt:
		if not is_on_floor():
			return
		else:
			move.isHurt = false
	
	move.move_update(delta)
	move.fly_update(delta)
	
	
func start_camera():
	isStart = false
	await get_tree().create_timer(0.6).timeout
	camera.enabled = true
	var current_viewport_cam = get_viewport().get_camera_2d()
	if current_viewport_cam:
		camera.global_position = current_viewport_cam.global_position
	InputBus.camera_enabled.emit()
	
	
func on_move_input(direction):
	move.set_direction(direction)
	
func on_jump_input():
	if is_on_floor() and not move.isHardLanding and move.canInput:
		move.start_jump_charge()
	
func on_jump_released():
	move.jump()
	
func on_fly_input_pressed():
	if not is_on_floor():
		move.set_flying(true)
		
func on_fly_input_released():
	move.set_flying(false)
	
	
func on_grapple_input():
	pass
	
func on_hit_detected(area: Area2D):
	move.isHurt = true
	move.hurt_push(area)
	
	hit_sound.play()
	
	animator.material.set_shader_parameter("blink_color", Color.RED)
	var tween = get_tree().create_tween()
	tween.tween_method(SetShader_BlinkIntensity, 1.0, 0.0, 0.5)
	var camera_tween = get_tree().create_tween()
	camera_tween.tween_method(StartCameraShake, 5.0, 1.0, 0.5)
	
	hurt_particles.restart()
	hurt_particles.emitting = true
	
	
func SetShader_BlinkIntensity(newValue: float):
	animator.material.set_shader_parameter("blink_intensity", newValue)
	
func StartCameraShake(intensity: float):
	var cameraOffset = cameraShakeNoise.get_noise_1d(Time.get_ticks_msec()) * intensity
	camera.offset.x = cameraOffset
	camera.offset.y = cameraOffset 

func _on_hit_detector_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		print("Hit enemy")
		on_hit_detected(area)
	if area.is_in_group("Golden Food"):
		power_up.play()
		animator.material.set_shader_parameter("blink_color", Color.GOLD)
		var tween = get_tree().create_tween()
		tween.tween_method(SetShader_BlinkIntensity, 1.0, 0.0, 0.5)
		var camera_tween = get_tree().create_tween()
		camera_tween.tween_method(StartCameraShake, 5.0, 1.0, 0.5)
	if area.is_in_group("Food"):
		power_up.play()
		animator.material.set_shader_parameter("blink_color", Color.WHITE)
		var tween = get_tree().create_tween()
		tween.tween_method(SetShader_BlinkIntensity, 1.0, 0.0, 0.5)
