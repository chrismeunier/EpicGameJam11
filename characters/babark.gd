extends Node2D

var isPlayerInArea : bool = false
var player : Node2D
@onready var area_2d: Area2D = %Area2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = %AudioStreamPlayer2D
@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	isPlayerInArea = true
	player = body
	
func _on_area_2d_body_exited(body: Node2D) -> void:
	isPlayerInArea = false
	player = null
	if audio_stream_player_2d.playing:
		audio_stream_player_2d.stop()

func _process(delta: float) -> void:
	if isPlayerInArea and not audio_stream_player_2d.playing:
		audio_stream_player_2d.play()
		audio_stream_player_2d.attenuation = get_sound_volume()

func get_sound_volume() -> float:
	if player == null:
		return 1
	else:
		var volume: float = 1 - (global_position.distance_to(player.global_position)	/ collision_shape_2d.shape.get_rect().size.x)
		return volume * 100
