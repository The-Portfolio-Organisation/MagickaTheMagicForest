extends Spatial

export(Resource) var itemResource
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	# Apparently godot doesn't handle custom classes for checks
	#if !(itemResource is ItemResource):
		#print_debug("SpawnItemOnReady - invalid resource type, must be ItemResource")
		#pass
		
	var item = ItemFactory.make_item(itemResource)
	item.transform.origin = transform.origin

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
