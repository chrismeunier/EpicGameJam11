extends VBoxContainer
class_name CommandPanel

signal add_command_to_sequence(command_id : int)

const COMMAND_ITEM = preload("res://interface/command_item_v_2.tscn")

@onready var h_box_container: HBoxContainer = %HBoxContainer

func _ready() -> void:
	#for item in get_sequence():
		#item.queue_free()
	#for i in range(4):
		#var cmd_item = COMMAND_ITEM.instantiate()
		#cmd_item.id = i
		#h_box_container.add_child(cmd_item)
		#cmd_item.pressed.connect(command_pressed.bind(i))
	for i in range(4):
		var commands = get_sequence()
		commands[i].pressed.connect(command_pressed.bind(i))


func command_pressed(id : int):
	add_command_to_sequence.emit(id)

func get_sequence():
	return h_box_container.get_children()

func disable_sequence():
	for item in get_sequence():
		item.custom_disabled = true

func enable_sequence():
	for item in get_sequence():
		item.custom_disabled = false
