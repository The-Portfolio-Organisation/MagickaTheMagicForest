extends Node

export(NodePath) var itemSubscene
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func make_item(var itemData):
	if itemData is ItemResource:
		pass
	else:
		return null

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
