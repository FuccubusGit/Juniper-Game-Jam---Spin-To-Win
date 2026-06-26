extends Camera2D


func _ready() -> void:
	InputBus.camera_enabled.connect(on_camera_enabled)
	
	
	
func on_camera_enabled():
	enabled = false
