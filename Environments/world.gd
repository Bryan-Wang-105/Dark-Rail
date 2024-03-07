extends Node3D
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
	
	# Update tab menu
	_update_menus()

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
	player_inventory.highlight_slot(player.hotbar_pos)

func _update_inventory():
	inventory_interface.set_player_inventory_data(player.inventory_data, player.hotbar_pos)
	
func _process(_delta: float) -> void:
	pass
