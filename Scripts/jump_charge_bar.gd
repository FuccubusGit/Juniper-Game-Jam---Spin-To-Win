extends ProgressBar

@onready var move: Node = $"../MovementComponent"


func _process(delta: float) -> void:
	if move.canInput:
		visible = move.isCharging
		value = move.jumpChargeTime
		
