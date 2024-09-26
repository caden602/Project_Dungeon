extends PointLight2D

var enemyInLight
var count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if enemyInLight:
		if $RayCast2D.get_collider() and $RayCast2D.get_collider().is_in_group("angel"):
			$RayCast2D.get_collider().in_light(true)
			print("Hitting Enemy ", count)
			count+= 1 
		# else:
			# $RayCast2D.get_collider().in_light(false)

func _on_area_2d_body_entered(body:Node2D):
	if body.is_in_group("angel"):
		enemyInLight = body


func _on_area_2d_body_exited(body:Node2D):
	if body.is_in_group("angel"):
		enemyInLight = null
