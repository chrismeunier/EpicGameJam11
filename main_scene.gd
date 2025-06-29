extends Node2D

@onready var controls: ControlPanel = %Controls
@onready var canvas_group: CanvasGroup = %CanvasGroup

const CENTERED_LVL_1 = preload("res://CenteredLevels/centered_lvl_1.tscn")
const CENTERED_LVL_2 = preload("res://CenteredLevels/centered_lvl_2.tscn")
const CENTERED_LVL_3 = preload("res://CenteredLevels/centered_lvl_3.tscn")
const CENTERED_LVL_4 = preload("res://CenteredLevels/centered_lvl_4.tscn")
const CENTERED_LVL_5 = preload("res://CenteredLevels/centered_lvl_5.tscn")
const CENTERED_LVL_6 = preload("res://CenteredLevels/centered_lvl_6.tscn")
const CENTERED_LVL_7 = preload("res://CenteredLevels/centered_lvl_7.tscn")

var levels_list = [\
	CENTERED_LVL_1,\
	CENTERED_LVL_2,\
	CENTERED_LVL_3,\
	CENTERED_LVL_4,\
	CENTERED_LVL_5,\
	CENTERED_LVL_6,\
	CENTERED_LVL_7]

var current_scene_index = 0

func _ready() -> void:
	Events.next_level.connect(on_next_level)
	#current_scene.set_scene_instance_load_placeholder(true)

func on_next_level() -> void:
	current_scene_index += 1
	if current_scene_index >= 6:
		current_scene_index = 6
	var scene = levels_list[current_scene_index]
	call_deferred("_deferred_goto_scene", scene)

func _deferred_goto_scene(scene):
	canvas_group.get_child(0).free()
	var current_scene = scene.instantiate()
	# Add it to the active scene, as child of root.
	canvas_group.add_child(current_scene)
	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	#get_tree().current_scene = current_scene
