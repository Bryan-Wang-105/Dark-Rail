extends Node3D

const DEFAULT_PORT: int = 12345

func _ready():
	multiplayer.peer_connected.connect(self._peer_connected)
	start_server()

# Initialize server
func start_server() -> void:
	var port: int = DEFAULT_PORT
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(port, 10)
	multiplayer.multiplayer_peer = peer

# Callback for peer_connected
func _peer_connected(id: int) -> void:
	print("Peer %s connected to server" % id)

@rpc("any_peer")
func spawn_player(player_name: String) -> void:
	print("Spawning player %s" % player_name)
	# EX:: rpc_id(client_id, "generate_player")
	
