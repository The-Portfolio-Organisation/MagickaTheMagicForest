extends Resource
class_name Spell

enum Types {Conjuration, Projectile, Zone, Self}

export(int) var ID;
export(String) var DisplayName;
export(Types) var type;
export(PackedScene) var hand_effect;
export(Resource) var item;

# Projectiles
export(PackedScene) var projectile_spell;

var head = MeshInstance.new(); # To get directions
var caster = KinematicBody.new(); # To get position and spawn things

func init(p_head, p_caster):
	check_integrity();
	head = p_head;
	caster = p_caster;

func check_integrity():
	if item:
		assert(item is ItemResourceType);
	
func cast():
	print("Casting " + str(DisplayName) + " with coords: " + str(head.transform));
	
	if type == Types.Projectile:
		var projectile = projectile_spell.instance();
		projectile.rotation = head.get_parent_spatial().rotation + head.rotation;
		projectile.translation = caster.translation + head.translation;
		caster.get_parent().add_child(projectile);
		
	
func uncast():
	print("Uncasting " + str(DisplayName) + " with coords: " + str(head.transform));
	
