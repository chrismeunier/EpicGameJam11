extends CanvasLayer
class_name ControlPanel

@onready var command_select: CommandPanel = %CommandSelect
@onready var command_sequence: SequencePanel = %CommandSequence
@onready var play_button: TextureButton = %PlayButton
@onready var undo_button: TextureButton = %UndoButton
@onready var cancel_button: TextureButton = %CancelButton
@onready var state_chart: StateChart = %StateChart
@onready var success_dialog: PanelContainer = %SuccessDialog
@onready var fail_dialog: PanelContainer = %FailDialog
@onready var end_dialog: PanelContainer = %EndDialog
@onready var camera_shift_commands: PanelContainer = %CameraShiftCommands

var music_played_once: bool = false
var changed_dimension: bool = false # to track the use of a teleporter
var should_wait: bool = false
var timeSec: float = 0.0

func _ready() -> void:
	command_sequence.clear_sequence()
	Events.add_command_to_sequence.connect(add_command_from_select)
	Events.to_select_mode.connect(idle_to_select_moves)
	Events.movement_ended.connect(to_ask_for_loop)
	Events.level_completed.connect(on_level_completed)
	Events.waitFor.connect(on_waitFor)
	Events.teleported.connect(change_music_after_teleportation)
	Events.newGame.connect(new_game)
	command_sequence.current_anim_ended.connect(command_anim_ended)

func _disable_all_buttons() -> void:
	command_select.disable_sequence()
	command_sequence.disable_sequence()
	_hide_play_undo_buttons()
	camera_shift_commands.disable_buttons()

func _enable_all_buttons() -> void:
	command_select.enable_sequence()
	command_sequence.enable_sequence()
	_show_play_undo_buttons()

func _hide_play_undo_buttons() -> void:
	play_button.disabled = true
	undo_button.disabled = true
	play_button.visible = false
	undo_button.visible = false

func _enable_cancel_button():
	cancel_button.disabled = false
	cancel_button.visible = true

func _hide_cancel_button():
	cancel_button.disabled = true
	cancel_button.visible = false


func _show_play_undo_buttons() -> void:
	play_button.disabled = false
	undo_button.disabled = false
	play_button.visible = true
	undo_button.visible = true

func _on_play_button_pressed() -> void:
	if command_sequence.is_not_empty():
		var index = randi() % AudioManager.play.get_child_count()
		var audio_player: AudioStreamPlayer = AudioManager.play.get_child(index)
		audio_player.play()
		await audio_player.finished
		await get_tree().create_timer(1).timeout
		state_chart.send_event("start_playing")

func _on_undo_button_pressed() -> void:
	command_sequence.remove_last_command_item()

func _show_camera_shift_panel():
	camera_shift_commands.show()

func _hide_camera_shift_panel():
	camera_shift_commands.hide()

func _is_shiftable_camera_level() -> bool:
	if get_parent().current_scene_index == 7:
		return true
	return false

# Signals interactions
func add_command_from_select(id: int):
	command_sequence.add_command(id)
	#print(id)

func change_music_after_teleportation():
	changed_dimension = true
	AudioManager.gameplay_music_one.stop()
	AudioManager.gameplay_music_loop.stop()
	AudioManager.music_heaven.stop()
	await AudioManager.tetcheu.finished
	AudioManager.music_heaven.play()

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
	if _is_shiftable_camera_level():
		_show_camera_shift_panel()
		camera_shift_commands.enable_buttons()
	AudioManager.startervoicedog.play()

func _on_selecting_state_exited() -> void:
	_disable_all_buttons()
	AudioManager.menu_eglise.stop()
	AudioManager.menu_music.stop()
	AudioManager.ambiance_oiseau.stop()

func _on_playing_state_entered() -> void:
	music_played_once = false
	changed_dimension = false
	_enable_cancel_button()
	Events.focus_player.emit()

func _on_playing_state_exited() -> void:
	_hide_cancel_button()
	AudioManager.gameplay_music_one.stop()
	AudioManager.gameplay_music_loop.stop()
	AudioManager.music_heaven.stop()
	Events.unfocus_player.emit()

# PLAYING STATES
func _on_init_state_entered() -> void:
	command_sequence.enable_sequence()
	state_chart.send_event("move")

func _on_signal_to_move_state_entered() -> void:
	state_chart.set_expression_property("finished_move", false)
	command_sequence.send_movement_direction()
	state_chart.set_expression_property("waiting_for_anim", true)
	command_sequence.start_animation()
	state_chart.send_event("to_wait")

func command_anim_ended():
	state_chart.set_expression_property("waiting_for_anim", false)
	state_chart.step()

func _on_awaiting_anim_state_stepped() -> void:
	if should_wait:
		await get_tree().create_timer(timeSec).timeout
		should_wait = false
	state_chart.send_event("ask_for_loop")

func to_ask_for_loop(misunderstanding: bool):
	#print("Move understood? ", not misunderstanding)
	if misunderstanding:
		command_sequence.failed_current_command()
	state_chart.send_event("ask_for_loop")
	state_chart.set_expression_property("finished_move", true)
	state_chart.step()

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

func _on_selecting_state_processing(_delta: float) -> void:
	if get_parent().current_scene_index == 7:
		if not AudioManager.menu_eglise.playing:
			AudioManager.menu_eglise.play()
	elif not AudioManager.menu_music.playing:
		AudioManager.menu_music.play()

	if not AudioManager.ambiance_oiseau.playing:
		AudioManager.ambiance_oiseau.play()

func _on_playing_state_processing(_delta: float) -> void:
	if changed_dimension:
		return
	if not music_played_once and not AudioManager.gameplay_music_one.playing:
		AudioManager.gameplay_music_one.play()
		music_played_once = true

	if music_played_once and not AudioManager.gameplay_music_one.playing:
		if not AudioManager.gameplay_music_loop.playing:
			AudioManager.gameplay_music_loop.play()

func on_level_completed() -> void:
	state_chart.send_event("end_game")
	_hide_camera_shift_panel()
	if (_is_last_level()):
		end_dialog.visible = true
		end_dialog.playAnimation()
		AudioManager.end_game.play()
	else:
		success_dialog.visible = true
		AudioManager.level_success.play()

func on_waitFor(seconds: float):
	should_wait = true
	timeSec = seconds

func _is_last_level() -> bool:
	# Parent is always the Main scene
	return get_parent().is_last_level()

# Next level pressed
func _on_next_level_button_pressed() -> void:
	state_chart.send_event("end_game")
	success_dialog.visible = false
	Events.next_level.emit()
	state_chart.send_event("start_selecting")

func _on_end_state_entered() -> void:
	Events.unfocus_player.emit()
	_hide_cancel_button()
	AudioManager.play_error_sound()

func _on_end_state_processing(_delta: float) -> void:
	if not success_dialog.visible:
		fail_dialog.visible = true

func _on_retry_button_pressed() -> void:
	state_chart.send_event("end_game")
	fail_dialog.visible = false
	Events.reset_level.emit()
	state_chart.send_event("start_selecting")

func _on_cancel_button_pressed() -> void:
	command_sequence.clear_sequence()
	fail_dialog.visible = true
	AudioManager.play_error_sound()
	state_chart.send_event("end_game")
	
func new_game() -> void:
	_hide_camera_shift_panel()
