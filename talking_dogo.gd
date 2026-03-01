extends CanvasLayer

@onready var anim = $TalkingDogo
@onready var controls = %Controls

var active_tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.add_command_to_sequence.connect(handleNewDirectionPressed)
	anim.play("talking")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func getRandomNumber():
	if get_parent().current_scene_index == 7:
		# For level 8 make appear the dog only on the left
		return randi_range(1, 2) 
	else:
		return randi_range(0, 3)
	

func handleNewDirectionPressed(id: int):
	var my_random_number = getRandomNumber()
	match my_random_number:
		0:
			#Bottom right
			anim.flip_v = false
			anim.flip_h = false
			anim.position = getDefaultPos(my_random_number)
			slide_out_and_back(anim.position, my_random_number)
		1:
			#Bottom Left
			anim.flip_v = false
			anim.flip_h = true
			anim.position = getDefaultPos(my_random_number)
			slide_out_and_back(anim.position, my_random_number)
		2:
			#Top left
			anim.flip_v = true
			anim.flip_h = true
			anim.position = getDefaultPos(my_random_number)
			slide_out_and_back(anim.position, my_random_number)
		_:
			#Top Right
			anim.flip_v = true
			anim.flip_h = false
			anim.position = getDefaultPos(my_random_number)
			slide_out_and_back(anim.position, my_random_number)

func getDirection(directionId: int):
	match directionId:
		0:
			return Vector2(-160, 0)
		1:
			return Vector2(160, 0)
		2:
			return Vector2(160, 0)
		_:
			return Vector2(-160, 0)

func getDefaultPos(directionId: int):
	match directionId:
		0:
			return Vector2(976, 641)
		1:
			return Vector2(-80, 641)
		2:
			return Vector2(-80, 80)
		_:
			return Vector2(976, 80)

func slide_out_and_back(position: Vector2, directionId: int):
	# kill tween if already ongoing
	if active_tween and active_tween.is_valid() :
		position = getDefaultPos(directionId)
		anim.position = position
		active_tween.kill()

	active_tween = create_tween()
	var start_pos = position
	var target_pos = position + getDirection(directionId)
	
	# 1. Slide Out
	active_tween.tween_property(anim, "position", target_pos, 0.1)
	
	# 2. Wait (Optional: Adds 0.5s pause at the target)
	active_tween.tween_interval(0.5) 
   
	# 3. Slide Back
	active_tween.tween_property(anim, "position", start_pos, 1.0)
