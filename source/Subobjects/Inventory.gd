extends Control

export(int) var rows = 5
export(int) var cols = 4
export(PackedScene) var baseContainer = load("res://Scenes/UI/hb_slot.tscn").instance()

func _ready():
	for i in range(rows * cols):
		
