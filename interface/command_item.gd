extends Button
class_name CommandItem

@export var id : int

@onready var label: Label = %Label
@onready var id_label: Label = %IdLabel
@onready var arrow: Arrow = %AnimatedArrow

@export var label_x_value := 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	arrow.set_direction(id)
	id_label.text = str(id)
	if label_x_value < 1:
		label.text = ""

func increment_label():
	label_x_value = label_x_value + 1
	label.text = "X" + str(label_x_value)


func _on_pressed() -> void:
	arrow.click()


func _on_mouse_entered() -> void:
	arrow.hover_in()


func _on_mouse_exited() -> void:
	arrow.hover_out()
