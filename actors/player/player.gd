extends CharacterBody2D

@export var projectile_scene: Resource
@export var move_speed: float = 200.0

func _process(delta):
    if (Input.is_action_pressed("move_left")):
        $MainSprite/AnimationPlayer.play("walk_left")
    elif (Input.is_action_pressed("move_right")):
        $MainSprite/AnimationPlayer.play("walk_right")
    else:
        $MainSprite/AnimationPlayer.play("player_idle")

func _input(event):
    if (event is InputEventMouseButton):
		# Only shoot on left click pressed down
        if (event.button_index == 1 and event.is_pressed()):
            var new_projectile = projectile_scene.instantiate()
            get_parent().add_child(new_projectile)
			
            var projectile_forward = Vector2.from_angle(rotation)
            new_projectile.fire(projectile_forward, 1000.0)
            new_projectile.position = $ProjectileRefPoint.global_position


func _physics_process(delta):
    look_at(get_viewport().get_mouse_position())
	
    velocity = Input.get_vector("move_left", \
    	"move_right", \
		"move_up", \
    	"move_down") * move_speed
    move_and_slide()
