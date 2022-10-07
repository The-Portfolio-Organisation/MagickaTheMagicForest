extends KinematicBody

export(int) var speed = 20;
export(float) var lifetime = 5.0;

func _physics_process(delta):
	if lifetime <= 0:
		queue_free()
	lifetime -= delta
	
	move_and_slide(-transform.basis.z * speed, Vector3.UP)
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		var body = collision.collider
		if collision:
			queue_free()
		

func to_deg(vect):
	return Vector3(rad2deg(vect.x), rad2deg(vect.y), rad2deg(vect.z))
	
