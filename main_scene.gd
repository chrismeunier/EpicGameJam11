extends Node2D


var levels_list = [\
	preload("res://Levels/Lvl1.tscn"),\
	preload("res://Levels/Lvl2.tscn"),\
	preload("res://Levels/Lvl3.tscn"),\
	preload("res://Levels/level_forest.tscn"),\
	preload("res://Levels/LvlPelouse.tscn"),\
	preload("res://Levels/LvlParking.tscn"),\
	preload("res://Levels/LvlAutoroute.tscn")]

var current_scene_index = 0

@onready var current_scene = $Game/Lvl1
@onready var controls: ControlPanel = %Controls
@onready var game: CanvasLayer = %Game

func _ready() -> void:
	Events.next_level.connect(on_next_level)

func on_next_level() -> void:
	current_scene_index += 1
	if current_scene_index >= 6:
		current_scene_index = 6
	var scene = levels_list[current_scene_index]
	call_deferred("_deferred_goto_scene", scene)

func _deferred_goto_scene(scene):
	current_scene.free()
	current_scene = scene.instantiate()
	# Add it to the active scene, as child of root.
	game.add_child(current_scene)
	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	#get_tree().current_scene = current_scene
