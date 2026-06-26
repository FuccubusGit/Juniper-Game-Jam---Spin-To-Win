extends Node


func _process(delta: float) -> void:
	read_move_input()
	read_fly_input()

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("Jump"):
		InputBus.jump_input.emit()
	if Input.is_action_just_released("Jump"):
		InputBus.jump_input_released.emit()
	
		
func read_move_input():
	var direction = Input.get_axis("Move Left", "Move Right")
	InputBus.move_input.emit(direction)
	
func read_fly_input():
	if Input.is_action_pressed("Fly"):
		InputBus.fly_input_pressed.emit()
	elif Input.is_action_just_released("Fly"):
		InputBus.fly_input_released.emit()
