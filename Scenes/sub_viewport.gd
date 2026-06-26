extends SubViewport


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	size = Vector2i(480, 270)
	render_target_update_mode = SubViewport.UPDATE_ALWAYS
