extends Node2D

var isPlayerInArea : bool = false
var player : Node2D
@onready var area_2d: Area2D = %Area2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = %AudioStreamPlayer2D
@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		isPlayerInArea = true
		player = body
		audio_stream_player_2d.autoplay = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if (body.name == "Player"):
		isPlayerInArea = false
		player = null
		audio_stream_player_2d.stop()
		audio_stream_player_2d.autoplay = false

func _process(delta: float) -> void:
	if isPlayerInArea:
		audio_stream_player_2d.volume_db = get_sound_volume()
		if !audio_stream_player_2d.playing:
			audio_stream_player_2d.play()

func get_sound_volume() -> float:
	if player == null:
		return 1
	else:
		var radius: float = collision_shape_2d.shape.get_rect().size.x / 2.0
		var distance: float = global_position.distance_to(player.global_position)
		return -(20 * distance / radius) + 6

func _on_success_detect_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		body.set_success_animation()
		isPlayerInArea = false
		visible = false
		Events.level_completed.emit()
