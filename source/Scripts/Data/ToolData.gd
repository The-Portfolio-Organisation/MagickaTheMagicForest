extends ItemData
class_name ToolData

export(int) var DamagePoints;
export(float) var AttackRange;

# Called when the node enters the scene tree for the first time.
func _ready():
	itemType = Constants.EItemType.Tool;

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
