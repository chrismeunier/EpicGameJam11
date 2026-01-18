extends Node2D

@export var Player : CharacterBody2D
@onready var p_cam_player: PhantomCamera2D = %PCamPlayer
@onready var p_cam_level_up: PhantomCamera2D = %PCamLevelUp

func _ready() -> void:
	p_cam_player.set_follow_target(Player)
	p_cam_player.set_follow_offset(Vector2(25.0, 0.0))
	# Connect the signals emitted by the control panel
	Events.focus_player.connect(priorize_player_cam)
	Events.unfocus_player.connect(priorize_scene_cam)
	Events.unshift_level_camera.connect(priorize_scene_cam)
	Events.shift_level_camera.connect(priorize_shifted_cam)

func priorize_player_cam():
	p_cam_player.set_priority(1)
	
func priorize_scene_cam():
	p_cam_player.set_priority(0)
	p_cam_level_up.set_priority(0)

func priorize_shifted_cam():
	p_cam_level_up.set_priority(2)
	
