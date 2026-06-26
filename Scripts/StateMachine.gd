extends Node

@onready var animator: AnimatedSprite2D = %Animator
@onready var move: Node = $"../MovementComponent"
@onready var energy: ProgressBar = $"../ProgressBar"

enum States {
	Idle,
	JumpReady,
	Jumping,
	Flying,
	Falling,
	HurtFalling,
}

@export var initialState: States
var currentState: States

func _ready() -> void:
	change_state(initialState)
	
func _process(delta: float) -> void:
	update_state()

func change_state(newState):
	if currentState == newState:
		return
		
	currentState = newState	
	
func select_state():
	if move.moveDirection <= 0.1:
		change_state(States.Idle)
	
	
func update_state():
	if move.isHurt:
		if currentState != States.HurtFalling:
			change_state(States.HurtFalling)
	match currentState:
		States.Idle:
			update_idle()
			
		States.JumpReady:
			update_jumpReady()
			
		States.Jumping:
			update_jumping()
			
		States.Flying:
			update_flying()
		States.Falling:
			update_falling()
		States.HurtFalling:
			update_hurt_falling()
				
				
func update_idle():
	animator.play("Idle")
	if move.isCharging:
		change_state(States.JumpReady)
	if not owner.is_on_floor():
		change_state(States.Jumping)
func update_jumpReady():
	if animator.animation != "JumpReady" and owner.is_on_floor():
		animator.play("JumpReady")
	if not owner.is_on_floor():
		change_state(States.Jumping)
		
func update_jumping():
	if animator.animation != "JumpingSide":
		animator.play("JumpingSide")
	if owner.is_on_floor():
		change_state(States.Idle)
	if move.isFlying:
		change_state(States.Flying)
	if move.isHurt:
		change_state(States.HurtFalling)
func update_flying():
	animator.play("Flying")
	if owner.velocity.y > 100 or !energy.canFly:
		change_state(States.Falling)
	if move.isHurt:
		change_state(States.HurtFalling)
	if owner.is_on_floor():
		change_state(States.Idle)
func update_falling():
	if animator.animation != "JumpingSide":
		animator.play("JumpingSide")
	if move.isFlying and energy.canFly:
		animator.stop()
		animator.frame = 0
		change_state(States.Flying)
	if move.isHurt:
		change_state(States.HurtFalling)
	if owner.is_on_floor():
		change_state(States.Idle)
func update_hurt_falling():
	if owner.is_on_floor():
		change_state(States.Idle)



	
	
