extends Node
class_name ItemRootComponent

var itemResourceData : ItemResource

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_item_resource_data(var newData : ItemResource):
	itemResourceData = newData
	update_components()
	
	
func update_components():
	# Error checks
	if itemResourceData == null:
		push_error("ItemRootComponent - ItemResource cannot be null.")
		return
	
	if itemResourceData.RefModel == null:
		push_error("ItemRootComponent - RefModel cannot be null.")
		return
	
	# Update components
	$RigidBody/MeshInstance.set_mesh(itemResourceData.RefModel)
	#$RigidBody/MeshInstance.set_surface_material(0, itemResourceData.RefModel.surface_get_material(0))
	
	if itemResourceData.RefCollider != null:
		$RigidBody/CollisionShape.shape = itemResourceData.RefCollider
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
