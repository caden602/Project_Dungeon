extends CharacterBody2D

var speed = 50
var player_chase = false
var player = null

func _ready():
	$Sprite2D/AnimationPlayer.play("downward_angel")

func _physics_process(delta):
	if player_chase:
		position += (player.position - position)/speed
	
		if(player.position.x - position.x < 0):
			$Sprite2D/AnimationPlayer.play("left_angel")
		else:
			$Sprite2D/AnimationPlayer.play("right_angel")
	

func _on_detection_area_body_entered(body:Node2D):
	player = body
	player_chase = true

func _on_detection_area_body_exited(body:Node2D):
	player = null
	player_chase = false

func in_light(state:bool):
	if (state):
		player_chase = false
		remove_from_group("angel")
	else:
		player_chase = true