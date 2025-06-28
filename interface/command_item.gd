extends Button
class_name CommandItem

@export var id: int
@export var label_x_value := 1

@onready var label: Label = %Label
@onready var id_label: Label = %IdLabel
@onready var arrow: Arrow = %AnimatedArrow


var custom_disabled: bool:
	get:
		return disabled
	set(value):
		disabled = value
		if disabled:
			arrow.disable()
		else:
			arrow.inactive()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	disable()
	arrow.set_direction(id)
	id_label.text = str(id)
	if label_x_value < 1:
		label.text = ""

func increment_label():
	label_x_value = label_x_value + 1
	label.text = "X" + str(label_x_value)
func decrement_label():
	label_x_value = label_x_value - 1
	label.text = "X" + str(label_x_value)
	if label_x_value < 1:
		label.text = ""
		# free here?
		call_deferred("queue_free")


func disable():
	custom_disabled = true
func enable():
	custom_disabled = false

func play_click():
	arrow.click()
func _on_pressed() -> void:
	play_click()

func play_hover_in():
	arrow.hover_in()
func _on_mouse_entered() -> void:
	play_hover_in()

func play_hover_out():
	arrow.hover_out()
func _on_mouse_exited() -> void:
	play_hover_out()
