extends TextureButton
class_name CommandItem

@export var id : int

@onready var label: Label = %Label
@onready var id_label: Label = %IdLabel

@export var label_x_value := 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	id_label.text = str(id)
	if label_x_value < 1:
		label.text = ""

func increment_label():
	label_x_value = label_x_value + 1
	label.text = "X" + str(label_x_value)
