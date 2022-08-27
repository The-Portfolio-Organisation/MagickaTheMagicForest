extends Control
class_name InventoryDisplay

export(int) var rows = 5
export(int) var cols = 4
export(PackedScene) var baseContainer = load("res://Scenes/UI/hb_slot.tscn")

export(Array, int) var start_content = [1001, null, 1004]

export(Resource) var items_table

func _ready():
	while (start_content.size() != rows * cols):
		start_content.append(null)
		
	$GridContainer.columns = cols
	for i in range(rows * cols):
		var  container = baseContainer.instance()
		container.name = str(i)
		print(items_table.table)
		container.table = items_table
		container.try_add_item(start_content[i])
		$GridContainer.add_child(container)
