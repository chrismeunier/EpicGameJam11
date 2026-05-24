extends Node

@onready var template_sound: AudioStreamPlayer = %TemplateSound

@onready var ambiance_oiseau: AudioStreamPlayer = %AmbianceOiseau
@onready var erreur_direction: Node = %ErreurDirection
@onready var instruction_right = %InstructionRight
@onready var instruction_up = %InstructionUp
@onready var instruction_left = %InstructionLeft
@onready var instruction_down = %InstructionDown
@onready var play = %Play
@onready var startervoicedog: AudioStreamPlayer = %Startervoicedog
@onready var error = %Error
@onready var level_success: AudioStreamPlayer = %LevelSuccess
@onready var end_game: AudioStreamPlayer = %EndGame
@onready var gameplay_right = %GameplayRight
@onready var gameplay_left = %GameplayLeft
@onready var gameplay_up = %GameplayUp
@onready var gameplay_down = %GameplayDown
@onready var audio_move: AudioStreamPlayer = %AudioMove
@onready var enter_car_zone = %EnterCarZone
@onready var car_noise: AudioStreamPlayer = %CarNoise
@onready var lawn_mower_noise: AudioStreamPlayer = %LawnMowerNoise
@onready var babark_barking: AudioStreamPlayer = %BabarkBarking
@onready var menu_music: AudioStreamPlayer = %MenuMusic
@onready var gameplay_music_one: AudioStreamPlayer = %GameplayMusicOne
@onready var gameplay_music_loop: AudioStreamPlayer = %GameplayMusicLoop
@onready var success_music: AudioStreamPlayer = %SuccessMusic
@onready var church_sound: AudioStreamPlayer = %"Ouh-A"
@onready var pleurs: AudioStreamPlayer = %Pleurs
@onready var cri: AudioStreamPlayer = %Cri
@onready var menu_eglise: AudioStreamPlayer = %MenuEglise
@onready var teleportation: AudioStreamPlayer = %Teleportation
@onready var tetcheu: AudioStreamPlayer = %Tetcheu

const DEFAULT_POLYPHONY = 20

var lawnMowerCount: int
var poussetteCount: int
var carCount: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		_set_polyphony(child)

func _set_polyphony(node: Node):
	if node is AudioStreamPlayer:
		node.set_max_polyphony(DEFAULT_POLYPHONY)
	elif node is Node:
		for child in node.get_children():
			_set_polyphony(child)

func TriggerLawnMower(add: bool):
	if add:
		lawnMowerCount += 1
		lawn_mower_noise.play()
	else:
		if lawnMowerCount > 0:
			lawnMowerCount -= 1
		if lawnMowerCount <= 0:
			lawn_mower_noise.stop()

func TriggerCar(add: bool):
	if add:
		carCount += 1
		car_noise.play()
	else:
		if carCount > 0:
			carCount -= 1
		if carCount <= 0:
			car_noise.stop()

func TriggerPoussette(add: bool):
	if add:
		poussetteCount += 1
		pleurs.play()
	else:
		if poussetteCount > 0:
			poussetteCount -= 1
		if poussetteCount <= 0:
			pleurs.stop()

func TriggerCherubin():
	cri.pitch_scale = 1.0
	cri.play()

func FleeingCherubin():
	cri.pitch_scale = 2.5
	cri.play()
	await cri.finished
	cri.play()

func play_error_sound():
	# play one undo sound
	var nb_undo_sounds = erreur_direction.get_child_count()
	var sound_index = randi() % nb_undo_sounds
	erreur_direction.get_child(sound_index).play()
