extends Node

# Connections infos
export var port = 4242
export var max_peers = 5

# Players infos
var peer = null
export var player_name = "Jesse Aarons"
var players = {}
var players_ready = []

# Signals for lobby GUI
signal connection_failed()
signal connection_succeeded()
signal game_ended()
signal game_error(err)


# Callback functions
func _player_connected(id):
	rpc_id(id, "register_player", player_name)

func _player_disconnected(id):
	if has_node("/root/Main"):
		if get_tree().is_network_server():
			emit_signal("game_error", "Player " + players[id] + " disconnected")
			end_game()
		else:
			unregister_player(id)

func _connected_ok():
	emit_signal("game_error", "Server disconnected")
	end_game()

func _connected_fail():
	get_tree().set_network_peer(null)
	emit_signal("connection_failed")

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self,"_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_server_disconnected")


# Lobby management functions
remote func register_player(new_player_name):
	var id = get_tree().get_rpc_sender_id()
	print(id)
	players[id] = new_player_name

remote func ready_to_start(id):
	assert(get_tree().is_network_server())

	if not id in players_ready:
		players_ready.append(id)

	if players_ready.size() == players.size():
		for p in players:
			rpc_id(p, "post_start_game")
		post_start_game()

func host_game(new_player_name):
	player_name = new_player_name
	peer = NetworkedMultiplayerENet.new()
	peer.create_server(port, max_peers)
	get_tree().set_network_peer(peer)

func join_game(ip, new_player_name):
	player_name = new_player_name
	peer = NetworkedMultiplayerENet.new()
	peer.create_client(ip, port)
	get_tree().set_network_peer(peer)


# Connection mannagement
func unregister_player(id):
	players.erase(id)

func end_game():
	if has_node("/root/Main"):
		get_node("/root/Main").queue_free()

	emit_signal("game_ended")
	players.clear()

remote func post_start_game():
	get_tree().set_pause(false)
	

# Logistic management
remote func pre_start_game(spawn_points):
	var world = load("res://Scenes/TestScene.tscn").instance()
	get_tree().get_root().add_child(world)

	get_tree().get_root().get_node("Lobby").hide()

	var player_scene = load("res://Subobjects/Player.tscn")

	for p_id in spawn_points:
		var spawn_pos = Transform.IDENTITY 
		
		if p_id != 1:
			spawn_pos.origin = Vector3(-1, 1, -11)
			
		var player = player_scene.instance()

		player.set_name(str(p_id)) 
		player.set_transform(spawn_pos)
		player.set_network_master(p_id)
		
		world.add_child(player)

	if not get_tree().is_network_server():
		rpc_id(1, "ready_to_start", get_tree().get_network_unique_id())
	elif players.size() == 0:
		post_start_game()

func begin_game():
	assert(get_tree().is_network_server())

	var spawn_points = {}
	spawn_points[1] = 0
	
	var spawn_point_idx = 1
	for p in players:
		spawn_points[p] = spawn_point_idx
		spawn_point_idx += 1
		
	for p in players:
		rpc_id(p, "pre_start_game", spawn_points)

	pre_start_game(spawn_points)

func get_player_list():
	return players.values()

func get_player_name():
	return player_name


