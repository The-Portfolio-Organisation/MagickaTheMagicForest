extends Node
class_name ItemRootComponent

var itemResourceData

# Called when the node enters the scene tree for the first time.
func _ready():
	update_components()
	
func set_item_data(itemData : ItemResource):
	itemResourceData = itemData
	update_components()
	
func update_components():
	$PickupableComponent.set_item_data(itemResourceData)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
