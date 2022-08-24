extends Spatial

export(PackedScene) var base_spell; # The mainframe for a spell
									# For now, only the albedo on a particle 
									# system change
export(NodePath) var main_caster_path; # The source of the main spells
export(NodePath) var sec_caster_path; # The source of the secondary spells

var main_caster = Node.new();
var sec_caster = Node.new();

var active_main_spell = null;
var active_sec_spell = null;

func _ready():
	main_caster = get_node(main_caster_path)
	sec_caster = get_node(sec_caster_path)
	print(main_caster)
	print(sec_caster)

func _physics_process(delta):
	if (is_network_master()):
		if(Input.is_action_just_pressed("main_spell")):
			active_main_spell = base_spell.instance();
			main_caster.add_child(active_main_spell);
		if(Input.is_action_just_released("main_spell")):
			main_caster.remove_child(active_main_spell);
			active_main_spell = null;
		if(Input.is_action_just_pressed("sec_spell")):
			active_sec_spell = base_spell.instance();
			sec_caster.add_child(active_sec_spell);
			print("hello world")
		if(Input.is_action_just_released("sec_spell")):
			sec_caster.remove_child(active_sec_spell);
			active_sec_spell = null;
	
