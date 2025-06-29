extends Node2D

var tilemap: TileMapLayer

@export var grid_color: Color = Color.SLATE_GRAY
@export var cell_size: Vector2i = Vector2i(32, 32)

func set_tilemap(tmap: TileMapLayer):
	tilemap = tmap

func _draw() -> void:
	var size = tilemap.get_used_rect().size
	var offset = Vector2(-16, -16)
	var line_width = -1.0  # Set thickness here

	for x in range(size.x):
		for y in range(size.y):
			var pos = tilemap.map_to_local(Vector2i(x, y)) + offset
			# Vertical line
			draw_line(pos, pos + Vector2(0, cell_size.y), grid_color, line_width)
			# Horizontal line
			draw_line(pos, pos + Vector2(cell_size.x, 0), grid_color, line_width)
