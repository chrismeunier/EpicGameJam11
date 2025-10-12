extends Node

@onready var controls: ControlPanel = %Controls
@onready var canvas_group: CanvasGroup = %CanvasGroup

const LVL_1 = preload("res://Levels/Lvl1.tscn")
const LVL_2 = preload("res://Levels/Lvl2.tscn")
const LVL_3 = preload("res://Levels/Lvl3.tscn")
const LVL_4 = preload("res://Levels/Lvl4.tscn")
const LVL_5 = preload("res://Levels/Lvl5.tscn")
const LVL_6 = preload("res://Levels/Lvl6.tscn")
const LVL_7 = preload("res://Levels/Lvl7.tscn")

var levels_list = [\
	LVL_1,\
	LVL_2,\
	LVL_3,\
	LVL_4,\
	LVL_5,\
	LVL_6,\
	LVL_7]

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
	canvas_group.add_child(current_scene)
	#get_tree().current_scene = current_scene
