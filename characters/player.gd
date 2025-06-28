extends Node2D

var tilemap: TileMapLayer
@onready var anim = $AnimatedSprite2D
@onready var rayCast = $AnimatedSprite2D/RayCast2D

var lastDirection = Vector2.ZERO
var can_move_input: bool = true
const MOVE_COOLDOWN := 0.84  # seconds between moves
var disturbanceLvl = "lvl0"
var signal_direction = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("idle_down")
	Events.go_left.connect(on_signal_go_left)
	Events.go_right.connect(on_signal_go_right)
	Events.go_down.connect(on_signal_go_down)
	Events.go_up.connect(on_signal_go_up)

func _process(_delta: float) -> void:
	if not can_move_input or anim.animation == "success":
		return
		
	# Uncomment this to move manually
	move_manually()
	
	if signal_direction != Vector2.ZERO:
		var new_signal: Vector2 = signal_direction
		if disturbanceLvl != "lvl0":
			new_signal = disturb_signal()

		Events.moved_successfully.emit(new_signal == signal_direction)

		if new_signal == signal_direction:
			play_sound(signal_direction)
		else:
			play_error_sound()
			
		signal_direction = new_signal
		move(signal_direction)
		signal_direction = Vector2.ZERO
	else:
		move(Vector2.ZERO)

func set_tilemap(tmap: TileMapLayer):
	tilemap = tmap

func move(direction: Vector2):
	if direction == Vector2.ZERO:
		handle_idle()
		return

	can_move_input = false

	var current_tile = tilemap.local_to_map(global_position)
	var target_tile = current_tile + Vector2i(direction)
	var tile_data: TileData = tilemap.get_cell_tile_data(target_tile)

	animate_player(direction)
	lastDirection = direction

	if tile_data.get_custom_data("walkable") == false:
		can_move_input = true
		return

	rayCast.target_position = direction * 64
	rayCast.force_raycast_update()
	if rayCast.is_colliding():
		can_move_input = true
		return

	var target_position = tilemap.map_to_local(target_tile)

	# Use SceneTreeTween to animate
	var tween := get_tree().create_tween()
	tween.tween_property(self, "global_position", target_position, MOVE_COOLDOWN).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	await tween.finished
	can_move_input = true

func setDisturbanceZoneLevel(lvl: String, isEntered: bool) -> void:
	if(isEntered):
		disturbanceLvl = lvl
	else:
		if lvl == "lvl3":
			disturbanceLvl = "lvl2"
		elif lvl == "lvl2":
			disturbanceLvl = "lvl1"
		else:
			disturbanceLvl = "lvl0"

func animate_player(direction: Vector2) -> void:
	if anim.animation == "success":
		return
	if direction == Vector2.DOWN and anim.animation != "move_down":
		anim.play("move_down")
	elif direction == Vector2.LEFT and anim.animation != "move_left":
		anim.play("move_left")
	elif direction == Vector2.RIGHT and anim.animation != "move_right":
		anim.play("move_right")
	elif direction == Vector2.UP and anim.animation != "move_up":
		anim.play("move_up")

func handle_idle() -> void:
	if anim.animation == "success":
		return
	if lastDirection == Vector2.DOWN and anim.animation != "idle_down":
		anim.play("idle_down")
	elif lastDirection == Vector2.LEFT and anim.animation != "idle_left":
		anim.play("idle_left")
	elif lastDirection == Vector2.RIGHT and anim.animation != "idle_right":
		anim.play("idle_right")
	elif lastDirection == Vector2.UP and anim.animation != "idle_up":
		anim.play("idle_up")

func move_manually() -> void:
	if Input.is_action_just_pressed("Down"):
		signal_direction = Vector2.DOWN
	elif Input.is_action_just_pressed("Up"):
		signal_direction = Vector2.UP
	elif Input.is_action_just_pressed("Right"):
		signal_direction = Vector2.RIGHT
	elif Input.is_action_just_pressed("Left"):
		signal_direction = Vector2.LEFT

func on_signal_go_left() -> void:
	signal_direction = Vector2.LEFT

func on_signal_go_right() -> void:
	signal_direction = Vector2.RIGHT

func on_signal_go_down() -> void:
	signal_direction = Vector2.DOWN

func on_signal_go_up() -> void:
	signal_direction = Vector2.UP
	
func disturb_signal() -> Vector2:
	match disturbanceLvl:
		"lvl1":
			return get_new_random_signal(0.3)
		"lvl2":
			return get_new_random_signal(0.6)
		"lvl3":
			return get_new_random_signal(0.95)
		_:
			return signal_direction

func get_new_random_signal(proba: float) -> Vector2:
	if (randf() < proba):
		match randi() % 4:
			0:
				return Vector2.LEFT
			1:
				return Vector2.RIGHT
			2:
				return Vector2.DOWN
			_:
				return Vector2.UP
	
	return signal_direction

func play_sound(direction: Vector2) -> void:
	var instructionPlayer: AudioStreamPlayer
	match direction:
		Vector2.LEFT:
			var index = randi() % AudioManager.gameplay_left.get_child_count()
			instructionPlayer = AudioManager.gameplay_left.get_child(index)
		Vector2.RIGHT:
			var index = randi() % AudioManager.gameplay_right.get_child_count()
			instructionPlayer = AudioManager.gameplay_right.get_child(index)
		Vector2.DOWN:
			var index = randi() % AudioManager.gameplay_down.get_child_count()
			instructionPlayer = AudioManager.gameplay_down.get_child(index)
		Vector2.UP:
			var index = randi() % AudioManager.gameplay_up.get_child_count()
			instructionPlayer = AudioManager.gameplay_up.get_child(index)
	
	instructionPlayer.play()
	var stepPlayer: AudioStreamPlayer = AudioManager.audio_move
	stepPlayer.play()

func play_error_sound() -> void:
	var index = randi() % AudioManager.error.get_child_count()
	var player: AudioStreamPlayer = AudioManager.error.get_child(index)
	player.play()
	
func set_success_animation() -> void:
	anim.play("success")
