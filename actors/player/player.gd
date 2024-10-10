extends CharacterBody2D

signal healthChanged

@export var projectile_scene: Resource
@export var move_speed: float = 200.0
@export var maxHealth = 3

@onready var currentHealth: int = maxHealth

enum anim_state {IDLE, LEFT, RIGHT, UP, DOWN, DEATH}

var current_state = anim_state.IDLE

func _process(delta):
	if (current_state != anim_state.DEATH):
		if (Input.is_action_pressed("move_left")):
			current_state = anim_state.LEFT
			$MainSprite/AnimationPlayer.play("walk_left")
		elif (Input.is_action_pressed("move_right")):
			current_state = anim_state.RIGHT
			$MainSprite/AnimationPlayer.play("walk_right")
		elif (Input.is_action_pressed("move_up")):
			current_state = anim_state.UP
			$MainSprite/AnimationPlayer.play("forward_walk")
		elif (Input.is_action_pressed("move_down")):
			current_state = anim_state.DOWN
			$MainSprite/AnimationPlayer.play("downward_walk")
		else:
			current_state = anim_state.IDLE
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
	velocity = Input.get_vector("move_left", \
		"move_right", \
		"move_up", \
		"move_down") * move_speed
	move_and_slide()

func _on_detect_area_body_entered(body: Node2D) -> void:
	player_hurt(body)

func player_hurt(body):
	if (body.is_in_group("enemy")):
		currentHealth -= 1
		healthChanged.emit(currentHealth)
		if currentHealth <= 0:
			current_state = anim_state.DEATH
			$MainSprite/AnimationPlayer.play("death")	

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if (anim_name == "death"):
		queue_free()
