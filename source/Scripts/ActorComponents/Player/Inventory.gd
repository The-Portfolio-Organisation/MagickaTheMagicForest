extends Control

export var my_images = ["res://Assets/Materials/sword.jpg"]
var id = 0

func _physics_process(delta):
	# (tmp) Exit the game
	if (Input.is_action_just_pressed("stop")):
		Connections.end_game()
	if (Input.is_action_just_pressed("pause")):
		if (is_visible_in_tree()):
			hide()
		else:
			show()
	if (Input.is_action_just_pressed("jump") and is_visible_in_tree()):
		id = (id + 1) % my_images.size()
		print(id)
		$TextureRect.texture = load(my_images[id])
