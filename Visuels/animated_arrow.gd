extends AnimatedSprite2D
class_name Arrow

enum {LEFT, RIGHT, UP, DOWN}

var disabled := true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play("inactive")

func set_direction(direction):
	match direction:
		LEFT:
			flip_h = true
			rotation = 0.0
		RIGHT:
			flip_h = false
			rotation = 0.0
		UP:
			rotation_degrees = -90.0
		DOWN:
			rotation_degrees = 90.0

func block_animation():
	play("wrong")
	modulate = Color.RED

func click():
	if is_playing():
		stop()
	play("click")

func hover_in():
	if not disabled:
		play("hover")
func hover_out():
	if not disabled:
		play_backwards("hover")

func disable():
	disabled = true
	if is_playing():
		stop()
	play("disabled")

func inactive():
	disabled = false
	play("inactive")
