extends Node

@onready var music_player: AudioStreamPlayer = AudioStreamPlayer.new()

func _ready() -> void:
	add_child(music_player)
	music_player.volume_db = -6  # Adjust volume

func play_music(stream: AudioStream, crossfade: float = 0.0):
	music_player.stream = stream
	music_player.play()
