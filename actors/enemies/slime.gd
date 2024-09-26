extends CharacterBody2D


var speed = 50
var player_chase = false
var player = null

func _physics_process(delta):
	if player_chase:
		position += (player.position - position)/speed
	
		if(player.position.x - position.x < 0):
			$Sprite2D/AnimationPlayer.play("hop_left")
		else:
			$Sprite2D/AnimationPlayer.play("hop_right")
	else:
		$Sprite2D/AnimationPlayer.play("slime_idle")
	


func _on_detection_area_body_entered(body:Node2D):
	player = body
	player_chase = true

func _on_detection_area_body_exited(body:Node2D):
	player = null
	player_chase = false