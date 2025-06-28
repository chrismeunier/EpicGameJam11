extends VBoxContainer

@onready var grid_container: GridContainer = %GridContainer

func get_sequence():
	return grid_container.get_children() # as Array[CommandItem]

func disable_sequence():
	for item in get_sequence():
		item.disabled = true

func enable_sequence():
	for item in get_sequence():
		item.disabled = false
