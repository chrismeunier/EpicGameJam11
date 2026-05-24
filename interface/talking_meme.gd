extends Node2D

@onready var anim = $Meme

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.newGame.connect(stop_all)
	trigger_event()

func stop_all():
	AudioManager.monologue_mémé.stop()
	anim.stop()

func trigger_event():
	# Creates a one-shot timer and waits for it to finish
	await get_tree().create_timer(7.0).timeout
	
	# This runs exactly 7 seconds later
	launch_animation_and_sound()

func launch_animation_and_sound():
	anim.play("talking")
	slide_out_and_back()
	AudioManager.monologue_mémé.play()

func slide_out_and_back():
	var tween = create_tween()
	
	# Save starting position
	var base_position = anim.position
	
	# CORRECTED: Use -= to actually change and save the value
	var target_position = anim.position
	target_position.x -= 500
	
	# 1. Slide Out
	tween.tween_property(anim, "position", target_position, 1.0)
	
	# 2. Wait 
	tween.tween_interval(5.6) 
   
	# 3. Slide Back
	tween.tween_property(anim, "position", base_position, 1.0)
	
	# 4. Wait 
	tween.tween_interval(2.0)
	
	# 5. Slide Out
	tween.tween_property(anim, "position", target_position, 1.0)
	
	# 6. Wait 
	tween.tween_interval(1.0) 
	
	# 7. Slide Back
	tween.tween_property(anim, "position", base_position, 1.0)
	
	# 8. Wait 
	tween.tween_interval(5.0) 
	
	# 9. Slide Out
	tween.tween_property(anim, "position", target_position, 1.0)
	
	# 10. Wait 
	tween.tween_interval(4.0) 
   
	# 11. Slide Back
	tween.tween_property(anim, "position", base_position, 1.0)

func _on_new_game_button_pressed() -> void:
	stop_all()
	
func _on_play_button_pressed() -> void:
	stop_all()
