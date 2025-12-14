extends StaticBody2D

var isPlayerInArea : bool = false
var player : Node2D
@onready var area_2d: Area2D = %Area2D
@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		isPlayerInArea = true
		player = body
		AudioManager.lawn_mower_noise.play()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if (body.name == "Player"):
		isPlayerInArea = false
		player = null
		AudioManager.lawn_mower_noise.stop()
		
func _process(delta: float) -> void:
	if (isPlayerInArea && !AudioManager.lawn_mower_noise.playing):
		AudioManager.lawn_mower_noise.play()
