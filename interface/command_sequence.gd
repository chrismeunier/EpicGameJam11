extends VBoxContainer
class_name SequencePanel

const COMMAND_ITEM = preload("res://interface/command_item.tscn")

@onready var grid_container: GridContainer = %GridContainer

var cmd_list = []

func _ready() -> void:
	#clear_sequence() # clean the default view
	for item in get_sequence():
		item.mouse_filter = MOUSE_FILTER_IGNORE
		item.toggle_mode = true

func get_sequence():
	return grid_container.get_children() # as Array[CommandItem]

func disable_sequence():
	for item in get_sequence():
		item.disabled = true

func enable_sequence():
	for item in get_sequence():
		item.disabled = false

func clear_sequence():
	cmd_list = []
	for item in get_sequence():
		item.queue_free()

func add_command(id : int):
	var cmd_item = COMMAND_ITEM.instantiate()
	cmd_item.id = id
	# increment the counter if same as previous
	cmd_list.append(id)
	grid_container.add_child(cmd_item)
	cmd_item.mouse_filter = MOUSE_FILTER_IGNORE
	cmd_item.toggle_mode = true
