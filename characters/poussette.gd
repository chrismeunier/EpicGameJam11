extends StaticBody2D

var isPlayerInArea : bool = false
var player : Node2D
@onready var area_2d: Area2D = %Area2D
@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		isPlayerInArea = true
		player = body
		#TODO: change logic to trigger the poussette's sound
		AudioManager.TriggerPoussette(true)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if (body.name == "Player"):
		isPlayerInArea = false
		player = null
		#TODO: change logic to trigger the poussette's sound
		AudioManager.TriggerPoussette(false)
