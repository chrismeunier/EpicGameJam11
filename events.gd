extends Node
# Autoload script
# Define all signals for communication between nodes
# when they are not hierarchically linked

func _ready() -> void:
	pass # Replace with function body.


### example:
signal example_signal
signal example_2_with_arg(val : int)
func __examples__() -> void:
	# link signal with function somewhere
	#example_signal.connect(function_to_call_when_signal_is_emitted)
	
	# send signal globally
	example_2_with_arg.emit(34) 
	# connected functions should be able to receive one int as parameter
	
