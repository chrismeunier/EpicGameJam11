extends Node2D

@onready var tilemap = $Map

func _ready() -> void:
	$Player.set_tilemap(tilemap)
	$Grid.set_tilemap(tilemap)
	$Vroum.set_path(get_car_path_for_world1())
	$Vroum.set_tilemap(tilemap)
	$Vroum2.set_path(get_car_path_for_world2())
	$Vroum2.set_tilemap(tilemap)
	$Vroum3.set_path(get_car_path_for_world2())
	$Vroum3.set_tilemap(tilemap)
	$Vroum4.set_path(get_car_path_for_world1())
	$Vroum4.set_tilemap(tilemap)
	$Vroum5.set_path(get_car_path_for_world1())
	$Vroum5.set_tilemap(tilemap)
	$Vroum6.set_path(get_car_path_for_world2())
	$Vroum6.set_tilemap(tilemap)
	$Vroum7.set_path(get_car_path_for_world1())
	$Vroum7.set_tilemap(tilemap)

func get_car_path_for_world1() -> Array:
	var path := []
	for i in 1:
		path.append(Vector2.LEFT)

	for i in 1:
		path.append(Vector2.RIGHT)
		
	return path
	
func get_car_path_for_world2() -> Array:
	var path := []
	for i in 1:
		path.append(Vector2.RIGHT)

	for i in 1:
		path.append(Vector2.LEFT)
		
	return path
