extends PanelContainer

@onready var up_button: TextureButton = %UpButton
@onready var down_button: TextureButton = %DownButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func disable_buttons():
	up_button.disabled = true
	down_button.disabled = true
	
func enable_buttons():
	up_button.disabled = false
	down_button.disabled = true

func _on_up_button_pressed() -> void:
	Events.shift_level_camera.emit()
	up_button.disabled = true
	down_button.disabled = false

func _on_down_button_pressed() -> void:
	Events.unshift_level_camera.emit()
	up_button.disabled = false
	down_button.disabled = true
