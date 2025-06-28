extends Node2D

@onready var area_2d: Area2D = %Area2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = %AudioStreamPlayer2D

func _ready() -> void:
	area_2d.monitoring = true
	area_2d.area_entered.connect(_on_area_entered)

func _on_area_entered() -> void:
	if not audio_stream_player_2d.playing:
		audio_stream_player_2d.play()
