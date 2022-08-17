extends Control

export var contents = []
export var bar_size = 9
var id = 0

export(Resource) var items_table

func _ready():
	for i in range(bar_size):
		var slot = load("res://Scenes/UI/hb_slot.tscn").instance()
		slot.name = str(i)
		slot.table = items_table
		
		$GridContainer.add_child(slot)
