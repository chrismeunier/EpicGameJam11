extends Node2D

@onready var tilemap = $Map

func _ready() -> void:
	$Player.set_tilemap(tilemap)
	$Grid.set_tilemap(tilemap)
	$Vroum.set_path(get_car_path_for_world1())
	$Vroum.set_tilemap(tilemap)
	$Vroum2.set_path(get_car_path_for_world2())
	$Vroum2.set_tilemap(tilemap)
	$Vroum3.set_path(get_car_path_for_world3())
	$Vroum3.set_tilemap(tilemap)

func get_car_path_for_world1() -> Array:
	var path := []
	for i in 2:
		path.append(Vector2.DOWN)

	for i in 2:
		path.append(Vector2.UP)
		
	return path
	
func get_car_path_for_world2() -> Array:
	var path := []
	for i in 2:
		path.append(Vector2.UP)

	for i in 2:
		path.append(Vector2.DOWN)
		
	return path
	
func get_car_path_for_world3() -> Array:
	var path := []
	for i in 19:
		path.append(Vector2.LEFT)

	for i in 19:
		path.append(Vector2.RIGHT)
		
	return path
