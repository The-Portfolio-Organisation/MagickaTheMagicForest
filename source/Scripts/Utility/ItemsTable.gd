extends Resource
class_name ItemTable


export(Array, Resource) var items
var table = {}

func _init():
	for item in items:
		table[item.ID] = item

