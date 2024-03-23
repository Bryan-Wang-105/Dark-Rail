extends Node3D

const DEFAULT_PORT: int = 12345

@onready var player: CharacterBody3D = $Player

@onready var inventory_interface: Control = $UI/InventoryInterface
@onready var player_inventory: PanelContainer = $UI/InventoryInterface/PlayerInventory

@onready var char_menu_panel = $UI/CharacterMenu/Panel
@onready var char_menu_perk_balance = $UI/CharacterMenu/Panel/PerkBalance
@onready var char_menu_hunger = $UI/CharacterMenu/Panel/Hunger
@onready var char_menu_fare = $UI/CharacterMenu/Panel/Fare

@onready var market_menu_panel = $UI/MarketMenu/Panel
@onready var market_menu_perk_balance = $UI/MarketMenu/Panel/PerkBalance
@onready var market_menu_fare = $UI/MarketMenu/Panel/Fare

@onready var market = $Market

func _ready() -> void:
	# Set panels to invisible
	char_menu_panel.visible = false
	market_menu_panel.visible = false
	
	# Scroll wheel signal
	player.connect("wheel_scroll", _on_scroll)
	
	# Update inventory signal
	player.connect("update_inventory", _update_inventory)
	
	# Update menus signal
	player.connect("update_menu", _update_menus)
	
	# Market update menus
	market.connect("update_menu", _update_menus)
	
	# Set initial inventory
	inventory_interface.set_player_inventory_data(player.inventory_data, 0)
	
	# SERVER
	# Set client connection callback
	multiplayer.connected_to_server.connect(self.init_client)
	# Join server on startup
	connect_to_server()
	
	# Make sure item in hand is set
	inventory_interface.showItemInHand()
	
	# Update tab menu
	_update_menus()

func connect_to_server() -> void:
	var peer = ENetMultiplayerPeer.new()
	#Set client to localhost
	peer.create_client('127.0.0.1', DEFAULT_PORT)
	multiplayer.multiplayer_peer = peer
	print("Connecting to server...")

func init_client() -> void:
	print("Connected to server.")
	var client_id: int = multiplayer.get_unique_id()
	var player_name: String = "Player_" + str(client_id)
	rpc_id(1, "spawn_player", player_name)

# Server func stub
@rpc("any_peer")
func spawn_player(client_id: int, player_name: String) -> void:
	pass

func _exit_screen():
	if char_menu_panel.visible:
		char_menu_panel.visible = false
	elif market_menu_panel.visible:
		market_menu_panel.visible = false

func _update_menus():
	char_menu_perk_balance.text = "Perk Balance: " + str(player.getPerkBalance())
	char_menu_hunger.text = "Hunger Level: " + str(player.getHungerLvl())
	char_menu_fare.text = "Fare: $" + str(player.getFare())
	
	market_menu_perk_balance.text = "Perk Balance: " + str(player.getPerkBalance())
	market_menu_fare.text = "Fare: $" + str(player.getFare())

func _on_scroll():
	# Skipped Inventory --> Player gap into just player interface
	player_inventory.highlight_slot(player.hotbar_pos)
	inventory_interface.showItemInHand()

func _update_inventory():
	print("Updateing2!!!")
	inventory_interface.set_player_inventory_data(player.inventory_data, player.hotbar_pos)
	inventory_interface.showItemInHand()
	
func _process(_delta: float) -> void:
	pass
