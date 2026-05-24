extends Node2D

@onready var tilemap = $Map
@onready var church_collision_shape: CollisionShape2D = %CollisionShape2D

var isPlayerInArea : bool = false
var player : Node2D

func _ready() -> void:
	$Player.set_tilemap(tilemap)
	$Grid.set_tilemap(tilemap)
	$Vroum.set_path(get_car_path_for_world1())
	$Vroum.set_tilemap(tilemap)
	$Vroum2.set_path(get_car_path_for_world2())
	$Vroum2.set_tilemap(tilemap)

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

func get_car_path_for_world1() -> Array:
	var path := []
	for i in 9:
		path.append(Vector2.LEFT)
	for i in 18:
		path.append(Vector2.RIGHT)
	for i in 9:
		path.append(Vector2.LEFT)
	return path
	
func get_car_path_for_world2() -> Array:
	var path := []
	for i in 16:
		path.append(Vector2.UP)
	for i in 16:
		path.append(Vector2.DOWN)
		
	return path
