extends ProgressBar

@onready var move: Node = $"../MovementComponent"
@onready var animator: AnimatedSprite2D = %Animator

var canFly: bool = true
var rate: float = 125
var energyMax: float = 100
var isGolden: bool = false
var goldenTimer: float = 0


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
	if isGolden:
		goldenTimer += delta
		if goldenTimer > 0.5:
			isGolden = false
		
func start_golden():
	isGolden = true
	move.maxLiftSpeed += 100

		
func _on_hit_detector_area_entered(area: Area2D) -> void:
	if area.is_in_group("Food") or area.is_in_group("Golden Food"):
		value = energyMax
		canFly = true
	if area.is_in_group("Golden Food"):
		start_golden()
		goldenTimer = 0
		
		
		
		
		
		
		
