extends AnimatedSprite2D
class_name Arrow

var disabled := true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play("inactive")

func set_direction(direction):
	match direction:
		0:
			flip_h = true
			rotation = 0.0
		1:
			flip_h = false
			rotation = 0.0
		2:
			rotation_degrees = -90.0
		3:
			rotation_degrees = 90.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
