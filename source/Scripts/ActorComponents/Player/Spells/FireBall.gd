extends KinematicBody

export(int) var speed = 20;

func _physics_process(delta):
	move_and_slide(-transform.basis.z * speed, Vector3.UP)
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		var body = collision.collider
		print("Collided with: ", body.name)

func to_deg(vect):
	return Vector3(rad2deg(vect.x), rad2deg(vect.y), rad2deg(vect.z))
	
