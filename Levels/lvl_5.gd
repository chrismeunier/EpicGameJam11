extends Node2D

@onready var tilemap = $Map

func _ready() -> void:
	$Player.set_tilemap(tilemap)
	$Grid.set_tilemap(tilemap)
