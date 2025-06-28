extends VBoxContainer

@onready var h_box_container: HBoxContainer = %HBoxContainer

func get_sequence():
	return h_box_container.get_children() # as Array[CommandItem]

func disable_sequence():
	for item in get_sequence():
		item.disabled = true

func enable_sequence():
	for item in get_sequence():
		item.disabled = false
