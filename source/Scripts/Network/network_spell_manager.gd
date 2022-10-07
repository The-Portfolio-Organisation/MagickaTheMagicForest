# this is my custom component system ... ignore this
extends Node
class_name NetworkFactory


var instance_count = 0

var instances:Array
var instance_cache = {}
var instance_preload = {}

var instance_path = {
	"fire_ball": "res://Scenes/spells/fire_ball.tscn",
	"player": "res://Subobjects/Player.tscn"
}

#------------------------ actually create things
func __make( what ):
	var a
	if instance_cache.has(what):
		#use allready loaded from cache
		a = instance_cache[what].instance()
	else:
		#load instance
		var o = load(instance_path[what])
		instance_cache[what] = o
		a = o.instance()

	instances.append(a)
	return a

#------------------------ get rid of things
func dispose( inst ):
	rpc("net_free", inst.get_path() )

#------------------------ actually get rid of things
remotesync func net_free( instPath ):
	print_debug("network-factory: free instance "+instPath)
	var inst = get_node( instPath )
	inst.queue_free()
	instances.erase( inst )

#------------------------ the function to call when creating something
func create( what, parent, rot, trans, name=null, p_id=null, on_ready=null):
	print_debug("network-factory: create instance of "+what+" in "+parent.get_path())
	assert( instance_path.has(what), "NetworkFactory has no instance path of \""+what+"\"")
	var a = __make( what )

	if not name:
		name = "instance_"+str(instance_count)
		instance_count += 1
	a.name = name
	a.rotation = rot
	a.translation = trans

	if on_ready:
		a.connect("ready",on_ready, "call_func", [], CONNECT_ONESHOT)

	parent.add_child(a)
	rpc("net_create", what, parent.get_path(), name, rot, trans )
	return a

#------------------------ gets called on the other clients
remote func net_create( what, parentPath, name, rot, trans, p_id=null ):
	var parent = get_node(parentPath)
	var a = __make( what )
	var icount = int(name)
	if icount > instance_count:
		instance_count = icount
	a.name = name
	a.rotation = rot
	a.translation = trans
	parent.add_child(a)
