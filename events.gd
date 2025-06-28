extends Node
# Autoload script
# Define all signals for communication between nodes
# when they are not hierarchically linked

# Signals to make granny move her body
signal go_left
signal go_right
signal go_up
signal go_down

# Signals to interact with the control panel
signal to_select_mode
signal movement_ended
# Call "Events.movement_ended.emit()" when movement is done

# Feedback signal to know if granny made the right move
signal moved_successfully(success: bool)


func _ready() -> void:
	pass # Replace with function body.


### example:
signal example_signal
signal example_2_with_arg(val : int)
func __examples__() -> void:
	# link signal with function somewhere
	#Events.example_signal.connect(function_to_call_when_signal_is_emitted)
	
	# send signal globally
	Events.example_2_with_arg.emit(34) 
	# connected functions should be able to receive one int as parameter
	
