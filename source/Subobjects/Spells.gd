extends Spatial

export(PackedScene) var base_spell; # The mainframe for a spell
									# For now, only the albedo on a particle 
									# system change
export(PackedScene) var main_caster; # The source of the main spells
export(PackedScene) var sec_caster; # The source of the secondary spells

var active_main_spell = null;
var active_sec_spell = null;

func _physics_process(delta):
	if (is_network_master()):
		if(Input.is_action_just_pressed("main_spell")):
			active_main_spell = base_spell.instance();
			$RHand.add_child(active_main_spell);
		if(Input.is_action_just_released("main_spell")):
			$RHand.remove_child(active_main_spell);
			active_main_spell = null;
	
