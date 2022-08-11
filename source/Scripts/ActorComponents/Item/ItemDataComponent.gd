extends Node

export(NodePath) var meshContainer
var itemResourceData : ItemResource

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_itemResourceData(var newData : ItemResource):
	itemResourceData = newData
	
	# Not tested yet
	var meshComponent = get_node(meshContainer)
	if meshComponent is MeshInstance:
		print("Was mesh instance!")
		meshComponent.mesh = itemResourceData.RefModel

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
