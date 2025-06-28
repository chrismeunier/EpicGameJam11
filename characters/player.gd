extends Node2D

var tilemap: TileMapLayer
@onready var anim = $AnimatedSprite2D

var lastDirection = Vector2.ZERO
var can_move: bool = true
const MOVE_COOLDOWN := 0.3  # seconds between moves

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Optional: preload or set up any timers
	pass

func _process(delta: float) -> void:
	if not can_move:
		return
		
	var input_direction = Vector2.ZERO
	if Input.is_action_just_pressed("Down"):
		input_direction = Vector2.DOWN
	elif Input.is_action_just_pressed("Up"):
		input_direction = Vector2.UP
	elif Input.is_action_just_pressed("Right"):
		input_direction = Vector2.RIGHT
	elif Input.is_action_just_pressed("Left"):
		input_direction = Vector2.LEFT
	
	if input_direction != Vector2.ZERO:
		move(input_direction)
	else:
		move(Vector2.ZERO)

func set_tilemap(tmap: TileMapLayer):
	tilemap = tmap

func move(direction: Vector2):
	if direction == Vector2.ZERO:
		handle_idle()
		return
	
	can_move = false  # lock input
	animate_player(direction)

	var currentTile = tilemap.local_to_map(global_position)
	var targetTile: Vector2i = Vector2i(
		currentTile.x + int(direction.x),
		currentTile.y + int(direction.y),
	)
	
	global_position = tilemap.map_to_local(targetTile)
	lastDirection = direction
	
	# Start cooldown
	await get_tree().create_timer(MOVE_COOLDOWN).timeout
	can_move = true

func animate_player(direction: Vector2) -> void:
	if direction == Vector2.DOWN and anim.animation != "move_down":
		anim.play("move_down")
	elif direction == Vector2.LEFT and anim.animation != "move_left":
		anim.play("move_left")
	elif direction == Vector2.RIGHT and anim.animation != "move_right":
		anim.play("move_right")
	elif direction == Vector2.UP and anim.animation != "move_up":
		anim.play("move_up")

func handle_idle() -> void:
	if lastDirection == Vector2.DOWN and anim.animation != "idle_down":
		anim.play("idle_down")
	elif lastDirection == Vector2.LEFT and anim.animation != "idle_left":
		anim.play("idle_left")
	elif lastDirection == Vector2.RIGHT and anim.animation != "idle_right":
		anim.play("idle_right")
	elif lastDirection == Vector2.UP and anim.animation != "idle_up":
		anim.play("idle_up")
