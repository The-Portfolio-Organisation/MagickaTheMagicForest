extends Control

export(int) var rows = 5
export(int) var cols = 4
export(PackedScene) var baseContainer = load("res://Scenes/UI/hb_slot.tscn")

func _ready():
	$GridContainer.columns = cols
	for i in range(rows * cols):
		var  container = baseContainer.instance()
		container.name = str(i)
		$GridContainer.add_child(container)
