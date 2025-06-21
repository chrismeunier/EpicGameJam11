extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

@export var SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionX := Input.get_axis("ui_left", "ui_right")
	var directionY := Input.get_axis("ui_up", "ui_down")

	if directionX or directionY:
		animated_sprite_2d.play("walking")
		velocity.x = directionX * SPEED
		velocity.y = directionY * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
		animated_sprite_2d.stop()

	move_and_slide()

	animated_sprite_2d.flip_h = directionX < 0

# func _process(delta: float) -> void:
# 	if Input.is_action_just_pressed("ui_accept"):
# 		animated_sprite_2d.play("default")
# 		if not audio_stream_player.playing:
# 			audio_stream_player.play()
