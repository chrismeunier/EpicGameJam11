extends Node2D

@onready var target_node = $ColorRect

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

func _ready():
	var shader_code := """
		shader_type canvas_item;

		uniform float ring_radius : hint_range(0.1, 0.5, 0.01) = 0.4;
		uniform float thickness_scalar : hint_range(0.0, 0.99, 0.05) = 0.7;
		uniform float oscillation_scalar : hint_range(0.0, 0.25, 0.005) = 0.025;
		uniform float speed : hint_range(0.0, 50.0, 0.1) = 1.0;
		uniform vec4 main_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
		uniform vec4 lerp_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);

		float range_lerp(float value, float min1, float min2, float max1, float max2){
			return min2 + (max2 - min2) * ((value - min1) / (max1 - min1));
		}

		void fragment() {
			float dist = distance(UV, vec2(0.5, 0.5));
			float o = cos(TIME * speed);
			float ring_size = ring_radius + o * oscillation_scalar;
			float alpha = step(dist, ring_size) * smoothstep(ring_size * (1.0 - thickness_scalar), ring_size, dist);
			alpha = alpha * 0.1;
			float w = range_lerp(o, -1.0, 1.0, 1.0, 0.0);
			COLOR = vec4(mix(main_color.rgb, lerp_color.rgb, w), alpha);
		}
	"""

	var shader := Shader.new()
	shader.code = shader_code

	var shader_material := ShaderMaterial.new()
	shader_material.shader = shader

	target_node.material = shader_material

	# Optional: Modify uniforms from GDScript
	shader_material.set_shader_parameter("main_color", Color(Color.YELLOW, 0.2))
	shader_material.set_shader_parameter("lerp_color", Color(Color.YELLOW, 0.2))
	shader_material.set_shader_parameter("speed", 2.5)
