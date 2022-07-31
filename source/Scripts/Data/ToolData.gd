extends ItemData
class_name ToolData

export(int) var DamagePoints = 1;
export(float) var AttackRange = 1.0;

# Called when the node enters the scene tree for the first time.
func _ready():
	itemType = Constants.EItemType.Tool;

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
