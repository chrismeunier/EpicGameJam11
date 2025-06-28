extends Node2D


func _on_detection_area_112_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		body.setDisturbanceZoneLevel("lvl1", true)

func _on_detection_area_112_body_exited(body: Node2D) -> void:
	if (body.name == "Player"):
		body.setDisturbanceZoneLevel("lvl1", false)

func _on_detection_area_80_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		body.setDisturbanceZoneLevel("lvl2", true)

func _on_detection_area_80_body_exited(body: Node2D) -> void:
	if (body.name == "Player"):
		body.setDisturbanceZoneLevel("lvl2", false)

func _on_detection_area_48_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		body.setDisturbanceZoneLevel("lvl3", true)

func _on_detection_area_48_body_exited(body: Node2D) -> void:
	if (body.name == "Player"):
		body.setDisturbanceZoneLevel("lvl3", false)
