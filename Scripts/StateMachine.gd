extends Node

@onready var animator: AnimatedSprite2D = %Animator
@onready var move: Node = $"../MovementComponent"

enum States {
	Idle,
	Hopping,
	Flying,
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
			
		States.Hopping:
			update_hopping()
			
		States.Flying:
			update_flying()
			
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
	if move.moveDirection >= 0.1:
		if not owner.is_on_floor:
			change_state(States.Flying)
		else:
			change_state(States.Hopping)
func update_hopping():
	pass
func update_flying():
	pass
func update_grappling():
	pass
func update_super():
	pass
func update_dead():
	pass
func update_respawning():
	pass

		
