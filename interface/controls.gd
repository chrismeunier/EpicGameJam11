extends CanvasLayer

@onready var command_select: VBoxContainer = %CommandSelect
@onready var command_sequence: VBoxContainer = %CommandSequence
@onready var play_button: TextureButton = %PlayButton
@onready var undo_button: TextureButton = %UndoButton
@onready var state_chart: StateChart = %StateChart

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


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
