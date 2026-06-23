extends Node

@onready var animator: AnimatedSprite2D = %Animator
@onready var move: Node = $"../MovementComponent"

enum States {
	Idle,
	JumpReady,
	Jumping,
	Flying,
	Falling,
	Grappling,
	Super,
	Dead,
	Respawning
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
		States.Grappling:
			update_grappling()
		States.Super:
			update_super()
		States.Dead:
			update_dead()
		States.Respawning:
			update_respawning()
				
				
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
func update_flying():
	animator.play("Flying")
	if owner.velocity.y > 100:
		change_state(States.Falling)
func update_falling():
	if animator.animation != "JumpingSide":
		animator.play("JumpingSide")
	if move.isFlying:
		animator.stop()
		animator.frame = 0
		change_state(States.Flying)
	if owner.is_on_floor():
		change_state(States.Idle)
func update_grappling():
	pass
func update_super():
	pass
func update_dead():
	pass
func update_respawning():
	pass

	
	
