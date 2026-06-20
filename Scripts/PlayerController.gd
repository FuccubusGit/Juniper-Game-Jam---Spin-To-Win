extends CharacterBody2D

@onready var grapple: Node2D = $"Grapple Controller"
@onready var move: Node = $MovementComponent

func _ready() -> void:
	InputBus.grapple_launched.connect(on_grapple_launched)
	InputBus.move_input.connect(on_move_input)
	InputBus.jump_input.connect(on_jump_input)
	InputBus.fly_input_pressed.connect(on_fly_input_pressed)
	InputBus.fly_input_released.connect(on_fly_input_released)
	
func _physics_process(delta: float) -> void:
	move.apply_gravity(delta)
	move.move_update(delta)
	move.fly_update(delta)
	move_and_slide()
	
	
func on_move_input(direction):
	move.set_direction(direction)
	
func on_jump_input():
	move.jump()
	
func on_fly_input_pressed():
	if not is_on_floor():
		move.set_flying(true)
	
func on_fly_input_released():
	move.set_flying(false)
	
func on_grapple_launched():
	pass
	
	
	
