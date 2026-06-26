extends CanvasLayer

@onready var fade_rect: ColorRect = $FadeRect
@onready var loading_bar: ProgressBar = $LoadingBar

func _ready() -> void:
	layer = 100
	fade_rect.color = Color.BLACK
	fade_rect.color.a = 0.0
	loading_bar.visible = false


func transition_to(scene_path: String, fade_duration: float = 0.4) -> void:
	await fade_out(fade_duration)
	
	loading_bar.visible = true
	loading_bar.value = 0
	

	ResourceLoader.load_threaded_request(scene_path)
	
	var progress_array: Array = []
	

	while true:
		var status = ResourceLoader.load_threaded_get_status(scene_path, progress_array)
		
		if status == ResourceLoader.THREAD_LOAD_LOADED:
			break
		elif status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			loading_bar.value = progress_array[0] * 100
		else:
			push_error("Loading failed: " + scene_path)
			break
		
		await get_tree().process_frame
	
	var new_scene = ResourceLoader.load_threaded_get(scene_path)
	get_tree().change_scene_to_packed(new_scene)
	
	loading_bar.visible = false
	await fade_in(fade_duration)


func fade_out(duration: float = 0.4) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(fade_rect, "color:a", 1.0, duration)
	await tween.finished


func fade_in(duration: float = 0.4) -> void:
	fade_rect.color.a = 1.0
	var tween = get_tree().create_tween()
	tween.tween_property(fade_rect, "color:a", 0.0, duration)
	await tween.finished
