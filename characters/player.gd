extends Node2D

@onready var anim = $AnimatedSprite2D
var lastDirection
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
	if (direction == Vector2.DOWN):
		anim.play("move_down")
	elif (direction == Vector2.LEFT):
		anim.play("move_left")
	elif (direction == Vector2.RIGHT):
		anim.play("move_right")
	elif (direction == Vector2.UP):
		anim.play("move_up")
