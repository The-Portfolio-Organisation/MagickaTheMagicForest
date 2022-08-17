extends Node

var item_data = {}

func _ready():
	var item_data_fiile = File.new()
	item_data_fiile.open('res://Scripts/Utility/test.json', File.READ)
	var item_data_json = JSON.parse(item_data_fiile.get_as_text())
	item_data_fiile.close()
	item_data = item_data_json.result
