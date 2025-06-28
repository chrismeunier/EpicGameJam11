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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
	state_chart.send_event("start_playing")

# Signals interactions
func add_command_from_select(id : int):
	command_sequence.add_command(id)

# INPUTS TO CHANGE STATES

func _on_inactive_state_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_2:
			state_chart.send_event("start_selecting")


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


func _on_selecting_state_entered() -> void:
	_enable_all_buttons()


func _on_selecting_state_exited() -> void:
	_disable_all_buttons()


func _on_playing_state_entered() -> void:
	command_sequence.enable_sequence()
