extends StaticBody2D

@export var move_interval := 1.0  # time between moves
@export var movement_duration := 0.3  # tween duration
@onready var anim = $AnimatedSprite2D

var tilemap: TileMapLayer
var path :Array
var current_step := 0

func _ready() -> void:
	pass

func set_tilemap(tmap: TileMapLayer):
	tilemap = tmap
	move_next()
	
func set_path(car_path: Array) -> void:
	path = car_path

func move_next() -> void:
	while true:
		var direction = path[current_step]
		current_step = (current_step + 1) % path.size()  # loop path

		var current_tile = tilemap.local_to_map(global_position)
		var next_tile = current_tile + Vector2i(direction)
		var tile_data := tilemap.get_cell_tile_data(next_tile)

		animate_car(direction)
		# Check if tile is walkable
		var target_pos = tilemap.map_to_local(next_tile)
		var tween = get_tree().create_tween()
		tween.tween_property(self, "global_position", target_pos, movement_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		await tween.finished
		await get_tree().create_timer(move_interval).timeout

func animate_car(direction: Vector2) -> void:
	if direction == Vector2.DOWN and anim.animation != "ride_down":
		anim.play("ride_down")
	elif direction == Vector2.LEFT and anim.animation != "ride_left":
		anim.play("ride_left")
	elif direction == Vector2.RIGHT and anim.animation != "ride_right":
		anim.play("ride_right")
	elif direction == Vector2.UP and anim.animation != "ride_up":
		anim.play("ride_up")
