extends Area
class_name PickupAreaComponent

export(NodePath) var inventoryNode

signal on_item_picked_up(pickedUpItem)

func _on_body_entered(body : Node):
	var pickupableComponent = body.get_parent().get_node("./PickupableComponent")
	if(pickupableComponent != null):
		var itemData = pickupableComponent.pick_up_item()
		emit_signal("on_item_picked_up", itemData)
