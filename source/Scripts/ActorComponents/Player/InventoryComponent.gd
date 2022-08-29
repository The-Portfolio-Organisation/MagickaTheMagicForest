extends Node
class_name InventoryComponent

export(NodePath) var pickupAreaNode

export(int) var slotAmount = 30
export(float) var dropAngle = 15.0
export(float) var dropOffset = 1.0
export(float) var dropVelocity = 3.0

var slots = []
var rootBody : Spatial

func _ready():
	slots.resize(slotAmount)
	rootBody = get_parent().get_node("./")

func drop_item(itemIndex : int):
	# Edge case handling
	if itemIndex < 0 or itemIndex >= 30: pass
	if slots[itemIndex] != null: pass
	
	# Make the dropped item
	var droppedItem = ItemFactory.make_item(slots[itemIndex])
	
	droppedItem.transform.origin = rootBody.transform.origin
	droppedItem.transform.origin


func add_item(itemData : ItemResource):
	# Find the earliest available index
	var itemIndex = 0
	for i in range(slotAmount):
		if slots[i] == null:
			itemIndex = i
			break
	
	slots[itemIndex] = itemData
	
	print("Added item at index: %s" % itemIndex)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func on_item_picked_up(pickedUpItem):
	add_item(pickedUpItem)
