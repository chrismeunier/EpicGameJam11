extends Node2D

@export var Player : CharacterBody2D
@onready var p_cam_player: PhantomCamera2D = %PCamPlayer

func _ready() -> void:
	p_cam_player.set_follow_target(Player)
	p_cam_player.set_follow_offset(Vector2(25.0, 0.0))
	# Connect the signals emitted by the control panel
	Events.focus_player.connect(priorize_player_cam)
	Events.unfocus_player.connect(priorize_scene_cam)

func priorize_player_cam():
	p_cam_player.set_priority(1)
	
func priorize_scene_cam():
	p_cam_player.set_priority(0)
