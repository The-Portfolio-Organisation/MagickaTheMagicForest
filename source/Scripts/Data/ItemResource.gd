extends Resource

export var ID = 0;
export(String) var DisplayKey = "DISPLAY_NAME"
export(PackedScene) var RefScene;
export(StreamTexture) var RefUIImage;

var itemType = EItemType.Default;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
