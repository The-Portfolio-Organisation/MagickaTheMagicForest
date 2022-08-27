extends Area
class_name PickupAreaComponent

export(NodePath) var inventoryNode

func _on_body_entered(body : Node):
	var pickupableComponent = body.get_parent().get_node("./PickupableComponent")
	if(pickupableComponent != null):
		var itemData = pickupableComponent.pick_up_item()
		# TODO: Add itemData to inventory
