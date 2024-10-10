extends CharacterBody2D


enum anim_state {IDLE, LEFT, RIGHT, DEATH}

var speed = 0.8
var player_chase = false
var player = null
var current_state = anim_state.IDLE

func _physics_process(delta):
	if (player_chase):
		velocity = (player.position - position)/speed
		move_and_slide()
	
		if(player.position.x - position.x < 0):
			current_state = anim_state.LEFT
			$Sprite2D/AnimationPlayer.play("hop_left")
		else:
			current_state = anim_state.RIGHT
			$Sprite2D/AnimationPlayer.play("hop_right")
	elif(current_state != anim_state.DEATH):
		current_state = anim_state.IDLE
		$Sprite2D/AnimationPlayer.play("slime_idle")


func _on_detection_area_body_entered(body:Node2D):
	player = body
	player_chase = true

func _on_detection_area_body_exited(body:Node2D):
	player = null
	player_chase = false

func _on_area_2d_area_entered(area:Area2D):
	if(area.is_in_group('grate')):
		position = area.global_position
		current_state = anim_state.DEATH
		player_chase = false
		$Sprite2D/AnimationPlayer.play("slime_death")

func _on_animation_player_animation_finished(anim_name):
	if(anim_name == "slime_death"):
		queue_free()
