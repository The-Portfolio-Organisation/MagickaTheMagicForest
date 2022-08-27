extends Node
class_name PickupableComponent

var itemData : ItemResource

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_item_data(var newItemData : ItemResource):
	itemData = newItemData
	
# Destroys the grounded item. Returns the item's data, which is expected to be added to the inventory.
func pick_up_item():
	get_parent().queue_free()
	return itemData
