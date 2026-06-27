extends Node

@onready var music_player: AudioStreamPlayer = AudioStreamPlayer.new()

func _ready() -> void:
	add_child(music_player)
	music_player.bus = "Music"

func play_music(stream: AudioStream, volume_db: float = -6.0):
	music_player.stream = stream
	music_player.volume_db = volume_db
	music_player.play()
	
# Main function - handles fade out + fade in
func transition_music(new_stream: AudioStream, fade_duration: float = 1.2):
	# Fade out current music
	if music_player.playing:
		var fade_out = get_tree().create_tween()
		fade_out.tween_property(music_player, "volume_db", -80.0, fade_duration / 2)
		await fade_out.finished
		music_player.stop()
	
	# Start new music faded in
	music_player.stream = new_stream
	music_player.volume_db = -80.0
	music_player.play()
	
	var fade_in = get_tree().create_tween()
	fade_in.tween_property(music_player, "volume_db", -6.0, fade_duration / 2)
