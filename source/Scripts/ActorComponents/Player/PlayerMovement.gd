extends KinematicBody

export var speed = 14
export var fall_acceleration = 75
export var jump_impulse = 20

var mouse_sens = 0.3
var camera_anglev = 0
var velocity = Vector3.ZERO

puppet var puppet_direction = Vector3.UP


func _init():
	# Disabling mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	# Moving
	var direction = Vector3.UP
	
	if (is_network_master()):
		if (Input.is_action_pressed("move_right")):
			direction += $Pivot.global_transform.basis.x
		if (Input.is_action_pressed("move_left")):
			direction -= $Pivot.global_transform.basis.x
		if (Input.is_action_pressed("move_backward")):
			direction += $Pivot.global_transform.basis.z
		if (Input.is_action_pressed("move_forward")):
			direction -= $Pivot.global_transform.basis.z
		
		rset("puppet_direction", direction)
	else:
		direction = puppet_direction

	if (direction != Vector3.ZERO):
		direction = direction.normalized()

	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	velocity.y -= fall_acceleration * delta
	
	velocity = move_and_slide(velocity, Vector3.UP)
	
	# Jumping
	if (is_on_floor() and Input.is_action_just_pressed("jump")):
		velocity.y += jump_impulse
	
	# (tmp) Exit the game
	if (Input.is_action_just_pressed("pause")):
		Connections.end_game()

func _input(event):   
	# Direction controlled by mouse
	if (event is InputEventMouseMotion):
		$Pivot.rotate_y(deg2rad(-event.relative.x*mouse_sens))
		
		var changev = -(event.relative.y) * mouse_sens
		
		if (camera_anglev + changev > -50 and camera_anglev + changev < 50):
			camera_anglev += changev
			$Pivot/Camera.rotate_x(deg2rad(changev))
