extends Control

export var my_images = ["res://Assets/Materials/sword.jpg"]
var id = 0

func _physics_process(delta):
	if (Input.is_action_just_pressed("jump") and is_visible_in_tree()):
		id = (id + 1) % my_images.size()
		print(id)
		$GridContainer/TextureRect/TextureRect.texture = load(my_images[id])
