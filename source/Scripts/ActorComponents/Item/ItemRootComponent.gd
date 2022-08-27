extends Node
class_name ItemRootComponent

export(Resource) var itemResourceData

# Called when the node enters the scene tree for the first time.
func _ready():
	if(typeof(itemResourceData) != ItemResource):
		print("ItemRootComponent - Invalid resource type for itemResourceData. Expected \"ItemResource\"")
		
	update_components()
	
func update_components():
	$PickupableComponent.set_item_data(itemResourceData)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
