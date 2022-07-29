extends KinematicBody

export var speed = 14
export var fall_acceleration = 75
export var jump_impulse = 20

var mouse_sens = 0.5
var velocity = Vector3.ZERO

puppet var puppet_direction = Vector3.UP
puppet var puppet_velocity = Vector3.UP
puppet var puppet_changev = 0
puppet var puppet_rotation = 0
puppet var camera_anglev = 0


func _ready():
	print(transform.basis.y.y)
	if is_network_master():
		$Pivot/Head/Camera.make_current()
	
	puppet_rotation = $Pivot.rotation.y

func _init():
	# Disabling mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	# Moving
	var direction = Vector3.UP
		
	if (Input.is_action_just_pressed("inventory")):
		if ($Inventory.is_visible_in_tree()):
			$Inventory.hide()
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			$Inventory.show()
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			print(get_items())
	
	if (is_network_master()):
		if (Input.is_action_pressed("move_right")):
			direction += $Pivot.global_transform.basis.x
		if (Input.is_action_pressed("move_left")):
			direction -= $Pivot.global_transform.basis.x
		if (Input.is_action_pressed("move_backward")):
			direction += $Pivot.global_transform.basis.z
		if (Input.is_action_pressed("move_forward")):
			direction -= $Pivot.global_transform.basis.z
		# (tmp) Exit the game
		if (Input.is_action_just_pressed("stop")):
			Connections.end_game()
	
		# Jumping
		if (is_on_floor() and Input.is_action_just_pressed("jump")):
			velocity.y += jump_impulse
		
		rset("puppet_direction", direction)
		rset("puppet_velocity", velocity)
	else:
		direction = puppet_direction
		velocity = puppet_velocity

	if (direction != Vector3.ZERO):
		direction = direction.normalized()

	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	velocity.y -= fall_acceleration * delta
	
	velocity = move_and_slide(velocity, Vector3.UP)
	
	$Pivot.rotation.y = puppet_rotation
	$Pivot/Head.rotation.x = deg2rad(camera_anglev)
	

func _input(event):   
	# Direction controlled by mouse
	if (event is InputEventMouseMotion):
		var changev = 0
		if (is_network_master() and Input.get_mouse_mode() != Input.MOUSE_MODE_VISIBLE):
			puppet_rotation = $Pivot.rotation.y + deg2rad(-event.relative.x * mouse_sens)
			changev = -(event.relative.y) * mouse_sens
			
			camera_anglev = rad2deg($Pivot/Head.rotation.x)
			
			if (camera_anglev + (-event.relative.y * mouse_sens) >= -60 
				and camera_anglev + (-event.relative.y * mouse_sens) <= 60):
				camera_anglev += (-event.relative.y * mouse_sens * mouse_sens)
			
			rset("puppet_changev", changev)
			rset("puppet_rotation", puppet_rotation)
			rset("camera_anglev", camera_anglev)
		else:
			changev = puppet_changev

func change_look_at(point):
	print("Transform: " + str(transform))
	print("Point: " + str(point))
	look_at(point, Vector3.UP)

func get_items():
	var items = []
	for i in $Inventory/GridContainer.get_children():
		if (i.ItemId):
			items.append(i.ItemId)
	
	return items
	
