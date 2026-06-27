extends Area2D
@onready var animator: AnimatedSprite2D = $AnimatedSprite2D
@onready var particles: GPUParticles2D = $GPUParticles2D
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D


func disable_area():
	
	monitorable = false
	monitoring = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		audio.play()
		call_deferred("disable_area")
		particles.restart()
		particles.emitting = true
		var tween = get_tree().create_tween()
		tween.tween_method(SetShader_DissolveLevel, 1.0, 0.0, 0.5)
		animator.visible = false
		
func SetShader_DissolveLevel(newValue: float):
	animator.material.set_shader_parameter("DissolveValue", newValue)
