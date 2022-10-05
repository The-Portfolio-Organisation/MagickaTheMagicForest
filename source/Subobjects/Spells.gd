extends Spatial

export(NodePath) var main_caster_path; # The source of the main spells
export(NodePath) var sec_caster_path; # The source of the secondary spells
export(NodePath) var caster_head_path;
export(NodePath) var caster_path;

var main_caster = Node.new();
var sec_caster = Node.new();
var caster_head = Node.new();
var caster = Node.new();

export (Resource) var main_spell = null;
export (Resource) var sec_spell = null;

func _ready():
	main_caster = get_node(main_caster_path);
	sec_caster = get_node(sec_caster_path);
	caster_head = get_node(caster_head_path);
	caster = get_node(caster_path);
	
	if main_spell:
		main_spell.init(caster_head, caster)
	if sec_spell:
		sec_spell.init(caster_head, caster)

func _physics_process(delta):
	if (is_network_master()):
		if(Input.is_action_just_pressed("main_spell") and main_spell):
			main_spell.cast()
		if(Input.is_action_just_released("main_spell") and main_spell):
			main_spell.uncast()
		if(Input.is_action_just_pressed("sec_spell") and sec_spell):
			sec_spell.cast()
		if(Input.is_action_just_released("sec_spell") and sec_spell):
			sec_spell.uncast()
		
	
