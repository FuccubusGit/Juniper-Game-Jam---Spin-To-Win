extends CharacterBody2D

@onready var move: Node = $MovementComponent

func _ready() -> void:
	InputBus.move_input.connect(on_move_input)
	InputBus.jump_input.connect(on_jump_input)
	InputBus.jump_input_released.connect(on_jump_released)
	InputBus.fly_input_pressed.connect(on_fly_input_pressed)
	InputBus.fly_input_released.connect(on_fly_input_released)
	InputBus.grapple_input.connect(on_grapple_input)
	
func _physics_process(delta: float) -> void:
	move_and_slide()
	move.apply_gravity(delta)
	move.move_update(delta)
	move.fly_update(delta)
	
	
	
func on_move_input(direction):
	move.set_direction(direction)
	
func on_jump_input():
	if is_on_floor():
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
	
	
	
