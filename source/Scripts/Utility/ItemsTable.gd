extends Node
class_name ItemTable

export(String) var path

func _init():
	load_itemData_from_dir("res://Data/ItemData")
	pass

func load_itemData_from_dir(var dirPath):
	var dir = Directory.new()
	if dir.open(dirPath) == OK:
		dir.list_dir_begin()
		
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				pass
				#load_itemData_from_dir(file_name)
			else:
				load_itemData_from_file(file_name)
			file_name = dir.get_next()
		
	else:
		print("An error occurred when trying to access the path.")
		
func load_itemData_from_file(var fileName):
	var itemResource = ResourceLoader.load("res://Data/ItemData/" + fileName, "tres", true)
	print("Found item!")

