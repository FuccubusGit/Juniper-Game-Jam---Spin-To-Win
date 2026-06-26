extends ProgressBar

@onready var move: Node = $"../MovementComponent"

var canFly: bool = true
var rate: float = 125
var energyMax: float = 100

func _process(delta: float) -> void:
	if move.isFlying:
		visible = true
		value -= (delta * rate)
	if value <= 0.0:
		canFly = false
		move.isFlying = false
	if owner.is_on_floor():
		value = energyMax
		visible = false
		canFly = true
		
func _on_hit_detector_area_entered(area: Area2D) -> void:
	if area.is_in_group("Food"):
		value = energyMax
		canFly = true
		
	
	
