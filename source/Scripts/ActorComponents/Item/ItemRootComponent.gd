extends Node
class_name ItemRootComponent

var itemResourceData : ItemResource

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_item_resource_data(var newData : ItemResource):
	itemResourceData = newData

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
