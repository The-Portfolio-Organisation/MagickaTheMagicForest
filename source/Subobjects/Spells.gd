extends Spatial

export(NodePath) var main_caster_path; # The source of the main spells
export(NodePath) var sec_caster_path; # The source of the secondary spells
export(NodePath) var caster_head_path;
export(NodePath) var caster_path;

var main_caster = Node.new();
var sec_caster = Node.new();
var caster_head = MeshInstance.new();
var caster = KinematicBody.new();

# Pupppets var
puppet var puppet_caster_head: MeshInstance
puppet var puppet_caster: Node

export (Resource) var main_spell = null;
export (Resource) var sec_spell = null;

func _ready():
	main_caster = get_node(main_caster_path);
	sec_caster = get_node(sec_caster_path);

func _physics_process(delta):
	if is_network_master():
		caster_head = get_node(caster_head_path);
		caster = get_node(caster_path);
		
		rset("puppet_caster_head", caster_head);
		rset("puppet_caster", caster);
	else:
		caster_head = puppet_caster_head
		caster = puppet_caster
	
	if(Input.is_action_just_pressed("main_spell") and main_spell):
		main_spell.cast(caster_head, caster)
	if(Input.is_action_just_released("main_spell") and main_spell):
		main_spell.uncast(caster_head, caster)
	if(Input.is_action_just_pressed("sec_spell") and sec_spell):
		sec_spell.cast(caster_head, caster)
	if(Input.is_action_just_released("sec_spell") and sec_spell):
		sec_spell.uncast(caster_head, caster)
