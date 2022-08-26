extends Resource
class_name Spell

enum Types {Conjuration, Projectile, Zone, Self}

export(int) var ID;
export(String) var DisplayName;
export(Types) var type;
export(PackedScene) var hand_effect;
export(Resource) var item;

func check_integrity():
	assert(item is ItemResourceType)
