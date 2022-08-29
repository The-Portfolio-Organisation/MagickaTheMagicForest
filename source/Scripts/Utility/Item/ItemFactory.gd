extends Node

func make_item(itemData : ItemResource):
	var itemSubobject = itemData.RefScene.instance()
	var itemRoot = itemSubobject.get_node("./")
	itemRoot.set_item_data(itemData)

	get_tree().current_scene.add_child(itemSubobject)
	
	return itemSubobject
	
func make_item_velocity(itemData : ItemResource, velocity : Vector3):
	var itemSubobject = make_item(itemData)
	
	var rigidBody : RigidBody = itemSubobject.get_node("./RigidBody")
	rigidBody.add_force(velocity, itemSubobject.transform.origin)
	
	return itemSubobject
