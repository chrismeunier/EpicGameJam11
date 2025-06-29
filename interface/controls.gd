extends CanvasLayer
class_name ControlPanel


@onready var command_select: CommandPanel = %CommandSelect
@onready var command_sequence: SequencePanel = %CommandSequence
@onready var play_button: TextureButton = %PlayButton
@onready var undo_button: TextureButton = %UndoButton
@onready var state_chart: StateChart = %StateChart


func _ready() -> void:
	command_sequence.clear_sequence()
	command_select.add_command_to_sequence.connect(add_command_from_select)
	Events.to_select_mode.connect(idle_to_select_moves)
	Events.movement_ended.connect(to_ask_for_loop)

func _disable_all_buttons() -> void:
	command_select.disable_sequence()
	command_sequence.disable_sequence()
	_disable_play_undo_buttons()
	
func _enable_all_buttons() -> void:
	command_select.enable_sequence()
	command_sequence.enable_sequence()
	_enable_play_undo_buttons()

func _disable_play_undo_buttons() -> void:
	play_button.disabled = true
	undo_button.disabled = true

func _enable_play_undo_buttons() -> void:
	play_button.disabled = false
	undo_button.disabled = false

func _on_play_button_pressed() -> void:
	if command_sequence.is_not_empty():
		var index = randi() % AudioManager.play.get_child_count()
		var audio_player : AudioStreamPlayer = AudioManager.play.get_child(index)
		audio_player.play()
		await audio_player.finished
		await get_tree().create_timer(1).timeout
		state_chart.send_event("start_playing")

func _on_undo_button_pressed() -> void:
	command_sequence.remove_last_command_item()


# Signals interactions
func add_command_from_select(id: int):
	command_sequence.add_command(id)
	#print(id)

# INPUTS TO CHANGE STATES
func idle_to_select_moves():
	state_chart.send_event("start_selecting")
func _on_inactive_state_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_2:
			Events.to_select_mode.emit()


func _on_selecting_state_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_3:
			state_chart.send_event("start_playing")


func _on_playing_state_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_1:
			state_chart.send_event("end_game")

# ENTRY/EXIT OF STATES
func _on_inactive_state_entered() -> void:
	_disable_all_buttons()
	command_sequence.clear_sequence()


func _on_selecting_state_entered() -> void:
	_enable_all_buttons()
	AudioManager.startervoicedog.play()


func _on_selecting_state_exited() -> void:
	_disable_all_buttons()


# PLAYING STATES
func _on_init_state_entered() -> void:
	command_sequence.enable_sequence()
	# maybe await on some signal...
	state_chart.send_event("move")


func _on_signal_to_move_state_entered() -> void:
	command_sequence.send_movement_direction()
	command_sequence.start_animation()


func to_ask_for_loop(move_succeeded:bool):
	if not move_succeeded:
		print("Failed to move!") #TODO
	state_chart.send_event("ask_for_loop")
func _on_repeat_state_entered() -> void:
	if command_sequence.should_loop():
		state_chart.send_event("count_down")
	else:
		command_sequence.pop_first_command()
		state_chart.send_event("no_repeat")


func _on_decrement_state_entered() -> void:
	command_sequence.decrement_current_command()
	state_chart.send_event("go_to_next")


func _on_next_move_state_entered() -> void:
	if command_sequence.is_not_empty():
		state_chart.send_event("move")
	else:
		state_chart.send_event("finished")
