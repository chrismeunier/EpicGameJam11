extends Area2D
class_name Teleporter

@export var map : TileMapLayer
@export var destination : Marker2D


func _on_body_entered(body: Node2D) -> void:
	var target_tile = map.local_to_map(destination.global_position)
	var target_pos = map.map_to_local(target_tile)
	#print("Waiting for end of movement")
	await Events.movement_ended
	#print("Go quantum mamie!")
	body.global_position = target_pos
