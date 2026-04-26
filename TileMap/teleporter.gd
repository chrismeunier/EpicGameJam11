extends Area2D
class_name Teleporter

@export var map : TileMapLayer
@export var destination : Marker2D
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D


func _on_body_entered(body: Node2D) -> void:
	var target_tile = map.local_to_map(destination.global_position)
	var target_pos = map.map_to_local(target_tile)
	
	Events.waitFor.emit(3)
	animated_sprite_2d.play()
	await get_tree().create_timer(1.5).timeout
	
	body.global_position = target_pos
