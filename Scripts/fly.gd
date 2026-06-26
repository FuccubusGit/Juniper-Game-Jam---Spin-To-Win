extends Area2D

@onready var timer: Timer = $Timer
@onready var animator: AnimatedSprite2D = $AnimatedSprite2D
@onready var animator2: AnimatedSprite2D = $AnimatedSprite2D2
@onready var particles: GPUParticles2D = $GPUParticles2D
@onready var light: PointLight2D

func _ready() -> void:
	light = get_node_or_null("PointLight2D")

func _on_timer_timeout() -> void:
	if light:
		light.visible = true
	monitorable = true
	monitoring = true
	var tween = get_tree().create_tween()
	tween.tween_method(SetShader_DissolveLevel, 0.0, 1.0, 0.5)
	await tween.finished
	animator2.visible = true

func disable_area():
	animator2.visible = false
	if light:
		light.visible = false
	monitorable = false
	monitoring = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		call_deferred("disable_area")
		timer.start()
		particles.restart()
		particles.emitting = true
		var tween = get_tree().create_tween()
		tween.tween_method(SetShader_DissolveLevel, 1.0, 0.0, 0.5)
		
func SetShader_DissolveLevel(newValue: float):
	animator.material.set_shader_parameter("DissolveValue", newValue)
