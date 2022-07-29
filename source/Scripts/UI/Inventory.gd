extends Control

export(int) var rows = 5
export(int) var cols = 4
export(PackedScene) var baseContainer = load("res://Scenes/UI/hb_slot.tscn")

export(Array) var content = [1001]

func _ready():
	$GridContainer.columns = cols
	for i in range(rows * cols):
		var  container = baseContainer.instance()
		container.name = str(i)
		$GridContainer.add_child(container)
	
	for i in range(content.size()):
		print(ItemData.item_data)
		var id = content[i]
		if (str(id) in ItemData.item_data):
			var item = ItemData.item_data[str(id)]
			print(item["name"])
			$GridContainer.get_child(i).get_child(0).set_texture(load("res://Assets/Materials/" + item["name"] + ".png"))
