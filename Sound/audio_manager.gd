extends Node

@onready var template_sound: AudioStreamPlayer = %TemplateSound

@onready var ambiance_gameplay: AudioStreamPlayer = %AmbianceOiseau
@onready var instruction_right = %InstructionRight
@onready var instruction_up = %InstructionUp
@onready var instruction_left = %InstructionLeft
@onready var instruction_down = %InstructionDown
@onready var play = %Play
@onready var startervoicedog = %Startervoicedog
@onready var error = %Error
@onready var level_success = %LevelSuccess
@onready var gameplay_right = %GameplayRight
@onready var gameplay_left = %GameplayLeft
@onready var gameplay_up = %GameplayUp
@onready var gameplay_down = %GameplayDown
@onready var audio_move = %AudioMove
@onready var enter_car_zone = %EnterCarZone
@onready var menu_music: AudioStreamPlayer = %MenuMusic
@onready var gameplay_music_one: AudioStreamPlayer = %GameplayMusicOne
@onready var gameplay_music_loop: AudioStreamPlayer = %GameplayMusicLoop
@onready var success_music: AudioStreamPlayer = %SuccessMusic

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
