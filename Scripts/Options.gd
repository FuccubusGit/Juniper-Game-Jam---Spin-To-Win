extends Control


@onready var master_slider: HSlider = $Master
@onready var music_slider: HSlider = $Music
@onready var sfx_slider: HSlider = $SFX

func _ready() -> void:
	
	master_slider.value = db_to_linear(AudioServer.get_bus_volume_db(0))  # Master
	music_slider.value = db_to_linear(AudioServer.get_bus_volume_db(1))   # Music
	sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(2))     # SFX

func _on_master_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db(value))


func _on_music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1, linear_to_db(value))


func _on_sfx_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2, linear_to_db(value))


func _on_close_menu_button_up() -> void:
	visible = false
