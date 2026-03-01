extends Node2D

@onready var tilemap = $Map
@onready var church_collision_shape: CollisionShape2D = %CollisionShape2D

var isPlayerInArea : bool = false
var player : Node2D

func _ready() -> void:
	$Player.set_tilemap(tilemap)
	$Grid.set_tilemap(tilemap, Vector2i(0,-18))
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

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		isPlayerInArea = true
		player = body
		AudioManager.church_sound.play()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if (body.name == "Player"):
		isPlayerInArea = false
		player = null
		AudioManager.church_sound.stop()

func get_sound_volume() -> float:
	if player == null:
		return 1
	else:
		var radius: float = church_collision_shape.shape.get_rect().size.x / 2.0
		var distance: float = church_collision_shape.global_position.distance_to(player.global_position)
		return -(20 * distance / radius)

func _process(_delta: float) -> void:
	if isPlayerInArea:
		AudioManager.church_sound.volume_db = get_sound_volume()
