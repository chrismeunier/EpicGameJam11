extends VBoxContainer
class_name SequencePanel

const COMMAND_ITEM = preload("res://interface/command_item_v_2.tscn")

@onready var grid_container: GridContainer = %GridContainer

# list of registered commands
var cmd_list : Array[int] = []

func _ready() -> void:
	for item in get_sequence():
		item.mouse_filter = MOUSE_FILTER_IGNORE
		item.toggle_mode = true

func get_sequence():
	return grid_container.get_children() # as Array[CommandItem]

func get_last_command_item() -> CommandItem:
	return get_sequence()[-1]

func remove_last_command_item():
	get_last_command_item().call_deferred("queue_free")
	cmd_list.pop_back()

func disable_sequence():
	for item in get_sequence():
		item.custom_disabled = true

func enable_sequence():
	for item in get_sequence():
		item.custom_disabled = false

func clear_sequence():
	cmd_list = []
	for item in get_sequence():
		item.queue_free()

func add_command(id : int):
	var cmd_item = COMMAND_ITEM.instantiate()
	cmd_item.id = id
	# increment the counter if same as previous
	if cmd_list and cmd_list[-1] == id:
		get_last_command_item().increment_label()
	else:
		grid_container.add_child(cmd_item)
		cmd_item.mouse_filter = MOUSE_FILTER_IGNORE
		cmd_item.toggle_mode = true
	cmd_list.append(id)
