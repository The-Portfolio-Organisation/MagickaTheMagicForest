extends Resource
class_name ItemTable


export(Array, Resource) var items
var table = {}

func add_dict():
	for item in items:
		print(item)
		table[item.ID] = item

