extends TextureButton
class_name CommandItem

@export var id : int

@onready var label: Label = %Label
@onready var id_label: Label = %IdLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	id_label.text = str(id)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
