extends PointLight2D

var enemyInLight
var count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(get_viewport().get_mouse_position())
	if enemyInLight:
		if ($RayCast2D.get_collider()):
			if ($RayCast2D.get_collider().is_in_group("angel")):
				$RayCast2D.get_collider().in_light(true)
		if ($RayCast2D/RayCast2D2.get_collider()):
			if ($RayCast2D/RayCast2D2.get_collider().is_in_group("angel")):
				$RayCast2D/RayCast2D2.get_collider().in_light(true)
		if ($RayCast2D/RayCast2D3.get_collider()):
			if ($RayCast2D/RayCast2D3.get_collider().is_in_group("angel")):
				$RayCast2D/RayCast2D3.get_collider().in_light(true)

func _on_area_2d_body_entered(body:Node2D):
	if body.is_in_group("angel"):
		enemyInLight = body


func _on_area_2d_body_exited(body:Node2D):
	if body.is_in_group("angel"):
		enemyInLight = null
