extends TextureRect

var MouseOver = false

func _input(event):
	if (event is InputEventMouseButton):
		if (MouseOver):
			hide()

func _on_TextureRect_mouse_entered():
	#Mouse is in
	MouseOver = true

func _on_TextureRect_mouse_exited():
	#Mouse is out
	MouseOver = false
