extends Node2D

@onready var tilemap = $Map

func _ready() -> void:
	$Player.set_tilemap(tilemap)
	$Grid.set_tilemap(tilemap)
	$Vroum.set_path(get_car_path_for_world())
	$Vroum.set_tilemap(tilemap)

func get_car_path_for_world() -> Array:
	var path := []
	for i in 15:
		path.append(Vector2.LEFT)

	for i in 15:
		path.append(Vector2.RIGHT)
	
	return path
