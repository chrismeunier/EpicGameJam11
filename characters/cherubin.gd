extends StaticBody2D

@export var linkedPoussette : Poussette # link to one Poussette node
@onready var rayon_de_fuite: Area2D = %RayonDeFuite

var flee_direction = Vector2.ZERO
var initial_speed = 5.0
var speed_multiplier = 1.0

func _physics_process(delta: float) -> void:
	if flee_direction != Vector2.ZERO:
		speed_multiplier += 0.5
		constant_linear_velocity = flee_direction * initial_speed * speed_multiplier
	move_and_collide(constant_linear_velocity)

func _on_rayon_de_fuite_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		pass # do something to make the baby flee and delete the poussette
		if linkedPoussette != null:
			linkedPoussette.call_deferred("queue_free")
		flee_direction = random_direction()
		
		await get_tree().create_timer(1.5).timeout
		call_deferred("queue_free")

func random_direction():
	var sign = [-1, 1]
	return Vector2(
		sign.pick_random()*randf(), 
		sign.pick_random()*randf()
		).normalized()

func _on_sound_radius_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		AudioManager.TriggerCherubin()
