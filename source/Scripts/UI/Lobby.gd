extends Node2D


func _ready():
	Connections.connect("connection_failed", self, "_on_connection_failed")
	Connections.connect("connection_succeeded", self, "_on_connection_success")
	Connections.connect("player_list_changed", self, "refresh_lobby")
	Connections.connect("game_ended", self, "_on_game_ended")
	Connections.connect("game_error", self, "_on_game_error")
	
	$Connect/NameEdt.text = Connections.player_name
	
# Buttuns action
func _on_HostBtn_pressed():
	if $Connect/NameEdt.text == "":
		$Connect/ErrorLabel.text = "Invalid name!"
		return

	$Connect.hide()
	$Players.show()
	$Connect/ErrorLabel.text = ""

	var player_name = $Connect/NameEdt.text
	Connections.host_game(player_name)
	refresh_lobby()

func _on_JoinBtn_pressed():
	if $Connect/NameEdt.text == "":
		$Connect/ErrorLabel.text = "Invalid name!"
		return
	
	var ip = $Connect/IpEdt.text
	if not ip.is_valid_ip_address():
		$Connect/ErrorLabel.text = "Invalid IP address!"
		return

	$Connect/ErrorLabel.text = ""
	$Connect/HostBtn.disabled = true
	$Connect/JoinBtn.disabled = true
	
	var player_name = $Connect/NameEdt.text
	Connections.join_game(ip, player_name)

func _on_StartBtn_pressed():
	Connections.begin_game()

func _on_CancelBtn_pressed():
	pass

# Signal responses
func _on_connection_success():
	$Connect.hide()
	$Players.show()

func _on_connection_failed():
	$Connect/HostBtn.disabled = false
	$Connect/JoinBtn.disabled = false
	$Connect/ErrorLabel.set_text("Connection failed.")

func _on_game_ended():
	show()
	$Connect.show()
	$Players.hide()
	$Connect/HostBtn.disabled = false
	$Connect/JoinBtn.disabled = false

func _on_game_error(errtxt):
	$ErrorDialog.dialog_text = errtxt
	$ErrorDialog.popup_centered_minsize()
	$Connect/HostBtn.disabled = false
	$Connect/JoinBtn.disabled = false

func refresh_lobby():
	var players = Connections.get_player_list()
	players.sort()
	$Players/List.clear()
	$Players/List.add_item(Connections.get_player_name() + " (You)")
	for p in players:
		$Players/List.add_item(p)

	$Players/StartBtn.disabled = not get_tree().is_network_server()

