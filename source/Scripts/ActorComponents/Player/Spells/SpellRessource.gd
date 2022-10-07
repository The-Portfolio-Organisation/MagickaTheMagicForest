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

func init(p_head, p_caster):
	check_integrity();

func check_integrity():
	if item:
		assert(item is ItemResourceType);
	
func cast(head: MeshInstance, caster: KinematicBody):
	print("Casting " + str(DisplayName) + " with coords: " + str(head.transform));
	
	if type == Types.Projectile:
		var rot = head.get_parent_spatial().rotation + head.rotation;
		var trans = caster.translation + head.translation;
		var projectile = NetworkSpellManager.create("fire_ball", caster.get_parent(), rot, trans);
		#projectile.rotation = head.get_parent_spatial().rotation + head.rotation;
		#projectile.translation = caster.translation + head.translation;
	
func uncast(head: MeshInstance, caster: KinematicBody):
	print("Uncasting " + str(DisplayName) + " with coords: " + str(head.transform));
	
