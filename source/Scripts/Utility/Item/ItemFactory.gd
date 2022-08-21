extends Node

#var itemSubscenePath = "res://Subobjects/Item.tscn"

var itemSubscene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func make_item(var itemData):
	# Edge case
	# Apparently gdscript can't check for custom classes
	#if !(itemData is ItemResource):
		#return null
	
	var itemSubobject = itemData.RefScene.instance()
	var itemRoot = itemSubobject.get_node("./")
	itemRoot.set_item_resource_data(itemData)

	get_tree().current_scene.add_child(itemSubobject)
	
	return itemSubobject

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
