extends CanvasLayer

@onready var play_button: TextureButton = %PlayButton
@onready var credits_button: TextureButton = %CreditsButton
@onready var paw_prints_anim: AnimatedSprite2D = %PawPrintsAnim
@onready var credits_container: PanelContainer = %CreditsContainer

func _ready() -> void:
	pass


func _on_play_button_pressed() -> void:
	hide()


func _on_credits_button_pressed() -> void:
	credits_container.show()


func _on_close_credits_button_pressed() -> void:
	credits_container.hide()
