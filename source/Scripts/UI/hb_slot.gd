extends TextureRect

var table

var MouseOver = false
var ItemId = null

func _input(event):
	
	if (Input.is_mouse_button_pressed(1)):
		if (MouseOver):
			try_add_item(1004)

func _on_TextureRect_mouse_entered():
	#Mouse is in
	MouseOver = true

func _on_TextureRect_mouse_exited():
	#Mouse is out
	MouseOver = false

func try_add_item(new_item_id):
	if (ItemId == null and new_item_id != null):
		ItemId = new_item_id
		table.add_dict()
		print(table.table)
		var new_item_name = table.table[ItemId].DisplayName
		
		var new_item_tex = table.table[ItemId].RefModel
		
		$TextureRect.texture = new_item_tex
		return true
	return false
