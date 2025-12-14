extends Node2D

@export var Player : CharacterBody2D
@onready var p_cam_player: PhantomCamera2D = %PCamPlayer

func _ready() -> void:
	p_cam_player.set_follow_target(Player)

func priorize_player_cam():
	p_cam_player.set_priority(1)
	
func priorize_scene_cam():
	p_cam_player.set_priority(0)
