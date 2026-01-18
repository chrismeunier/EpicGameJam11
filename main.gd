extends Node

@onready var controls: ControlPanel = %Controls

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
	Events.reset_level.connect(on_reset_level)

func on_next_level() -> void:
	current_scene_index += 1
	if current_scene_index >= 6:
		current_scene_index = 6
	var scene = levels_list[current_scene_index]
	call_deferred("_deferred_goto_scene", scene)

func _deferred_goto_scene(scene):
	for child in self.get_children():
		if child is Node2D:
			child.call_deferred("free")
	var current_scene = scene.instantiate()
	self.add_child(current_scene)

func on_reset_level() -> void:
	var scene = levels_list[current_scene_index]
	call_deferred("_deferred_goto_scene", scene)

func is_last_level() -> bool:
	return levels_list.size() - 1 == current_scene_index
