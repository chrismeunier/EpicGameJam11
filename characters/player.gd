extends Node2D

var tilemap: TileMapLayer
@onready var anim = $AnimatedSprite2D
var lastDirection = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("Down")):
		move(Vector2.DOWN)
	elif (Input.is_action_just_pressed("Up")):
		move(Vector2.UP)
	elif (Input.is_action_just_pressed("Right")):
		move(Vector2.RIGHT)
	elif (Input.is_action_just_pressed("Left")):
		move(Vector2.LEFT)
	else:
		move(Vector2.ZERO)

func set_tilemap(tmap: TileMapLayer):
	tilemap = tmap

func move(direction: Vector2):
	var currentTile = tilemap.local_to_map(global_position)
	var targetTile: Vector2i = Vector2i(
		currentTile.x + direction.x,
		currentTile.y + direction.y,
	)
	animate_player(direction)
	global_position = tilemap.map_to_local(targetTile)
	lastDirection = direction

func animate_player(direction: Vector2) -> void:
	if (direction == Vector2.DOWN):
		anim.play("move_down")
	elif (direction == Vector2.LEFT):
		anim.play("move_left")
	elif (direction == Vector2.RIGHT):
		anim.play("move_right")
	elif (direction == Vector2.UP):
		anim.play("move_up")
	elif (direction == Vector2.ZERO):
		handle_idle()

func handle_idle() -> void:
	if (lastDirection == Vector2.DOWN):
		anim.play("idle_down")
	elif (lastDirection == Vector2.LEFT):
		anim.play("idle_left")
	elif (lastDirection == Vector2.RIGHT):
		anim.play("idle_right")
	elif (lastDirection == Vector2.UP):
		anim.play("idle_up")
