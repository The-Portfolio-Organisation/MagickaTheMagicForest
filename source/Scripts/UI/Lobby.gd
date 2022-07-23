extends Node2D


func _ready():
	Connections.connect("connection_failed", self, "_on_connection_failed")
	Connections.connect("connection_succeeded", self, "_on_connection_success")
	Connections.connect("player_list_changed", self, "refresh_lobby")
	Connections.connect("game_ended", self, "_on_game_ended")
	Connections.connect("game_error", self, "_on_game_error")
	
	$Control/Connect/NameEdt.text = Connections.player_name
	
# Buttuns action
func _on_HostBtn_pressed():
	if $Control/Connect/NameEdt.text == "":
		$Control/Connect/ErrorLabel.text = "Invalid name!"
		return

	$Control/Connect.hide()
	$Control/Players.show()
	$Control/Connect/ErrorLabel.text = ""

	var player_name = $Control/Connect/NameEdt.text
	Connections.host_game(player_name)
	refresh_lobby()

func _on_JoinBtn_pressed():
	if $Control/Connect/NameEdt.text == "":
		$Control/Connect/ErrorLabel.text = "Invalid name!"
		return
	
	var ip = $Control/Connect/IpEdt.text
	if not ip.is_valid_ip_address():
		$Control/Connect/ErrorLabel.text = "Invalid IP address!"
		return

	$Control/Connect/ErrorLabel.text = ""
	$Control/Connect/HostBtn.disabled = true
	$Control/Connect/JoinBtn.disabled = true
	
	var player_name = $Control/Connect/NameEdt.text
	Connections.join_game(ip, player_name)

func _on_StartBtn_pressed():
	Connections.begin_game()

func _on_CancelBtn_pressed():
	Connections.end_game()

# Signal responses
func _on_connection_success():
	$Control/Connect.hide()
	$Control/Players.show()

func _on_connection_failed():
	$Control/Connect/HostBtn.disabled = false
	$Control/Connect/JoinBtn.disabled = false
	$Control/Connect/ErrorLabel.set_text("Connection failed.")

func _on_game_ended():
	show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$Control/Connect.show()
	$Control/Players.hide()
	$Control/Connect/HostBtn.disabled = false
	$Control/Connect/JoinBtn.disabled = false

func _on_game_error(errtxt):
	$Control/ErrorDialog.dialog_text = errtxt
	$Control/ErrorDialog.popup_centered_minsize()
	$Control/Connect/HostBtn.disabled = false
	$Control/Connect/JoinBtn.disabled = false

func refresh_lobby():
	var players = Connections.get_player_list()
	players.sort()
	$Control/Players/List.clear()
	$Control/Players/List.add_item(Connections.get_player_name() + " (You)")
	for p in players:
		$Control/Players/List.add_item(p)

	$Control/Players/StartBtn.disabled = not get_tree().is_network_server()

