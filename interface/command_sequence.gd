extends VBoxContainer
class_name SequencePanel

signal current_anim_ended

enum {LEFT, RIGHT, UP, DOWN}

const COMMAND_ITEM = preload("res://interface/command_item_v_2.tscn")
@export var control_state_chart : StateChart
# list of registered commands
var cmd_list: Array[int] = []
var current_item : CommandItem
@onready var grid_container: GridContainer = %GridContainer

func _ready() -> void:
	for item in get_sequence():
		item.mouse_filter = MOUSE_FILTER_IGNORE
		item.toggle_mode = true

func get_sequence():
	return grid_container.get_children()

func get_last_command_item() -> CommandItem:
	if grid_container.get_child_count():
		return get_sequence()[-1]
	return null

func get_first_command_item() -> CommandItem:
	if grid_container.get_child_count():
		for i in range(grid_container.get_child_count()):
			if grid_container.get_child(i).disabled:
				continue
			return get_sequence()[i]
	return null

func remove_last_command_item():
	if grid_container.get_child_count():
		var last_item = get_last_command_item()
		if len(cmd_list) > 1 and cmd_list[-1] == cmd_list[-2]:
			last_item.decrement_label()
		else:
			last_item.call_deferred("queue_free")
		cmd_list.pop_back()

func disable_sequence():
	for item in get_sequence():
		item.custom_disabled = true

func enable_sequence():
	for item in get_sequence():
		item.custom_disabled = false
		item.mouse_filter = MOUSE_FILTER_IGNORE

func clear_sequence():
	cmd_list = []
	for item in get_sequence():
		item.queue_free()

func add_command(id: int):
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

func start_animation():
	current_item = get_first_command_item()
	if not current_item.hover_animation_finished.is_connected(sequence_panel_animation_finished):
		current_item.hover_animation_finished.connect(sequence_panel_animation_finished)
	current_item.play_hover_in()

func sequence_panel_animation_finished():
	current_anim_ended.emit()

func send_movement_direction():
	trigger_movement(cmd_list.front())

func trigger_movement(direction: int):
	match direction:
		LEFT:
			Events.go_left.emit()
			#print("Going left!")
		RIGHT:
			Events.go_right.emit()
			#print("Going right!")
		UP:
			Events.go_up.emit()
			#print("Going up!")
		DOWN:
			Events.go_down.emit()
			#print("Going down!")
	#! FIXME some hack to test the states
	#await get_tree().create_timer(2).timeout
	#! DEBUG spaghettiiiii
	if get_parent().get_parent().get_parent().get_parent().get_parent() == get_tree().root:
		Events.movement_ended.emit(false)

func failed_current_command():
	current_item = get_first_command_item()
	if current_item:
		current_item.stuck()
		#control_state_chart.set_expression_property("finished_move", true)
		#control_state_chart.set_expression_property("waiting_for_anim", true)
		#control_state_chart.step()
		#control_state_chart.send_event("force_to_rep")

func should_loop() -> bool:
	if get_first_command_item().label_x_value > 1:
		return true
	return false

func decrement_current_command():
	get_first_command_item().decrement_label()
	cmd_list.pop_front()

func pop_first_command():
	cmd_list.pop_front()
	var command_item = get_first_command_item()
	command_item.disable()
	command_item.decrement_label()

func is_not_empty() -> bool:
	#print("Sequence over ? ", cmd_list, get_sequence())
	return bool(len(cmd_list))
