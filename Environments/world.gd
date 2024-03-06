extends Node3D
@onready var player: CharacterBody3D = $Player

@onready var inventory_interface: Control = $UI/InventoryInterface
@onready var player_inventory: PanelContainer = $UI/InventoryInterface/PlayerInventory

@onready var panel: Panel = $UI/Panel
@onready var perk_balance: Label = $UI/Panel/PerkBalance
@onready var hunger: Label = $UI/Panel/Hunger

func _ready() -> void:
	# Set panel to invisible
	panel.visible = false
	
	# Scroll wheel signal
	player.connect("wheel_scroll", _on_scroll)
	
	# Update inventory signal
	player.connect("update_inventory", _update_inventory)
	
	# Update inventory signal
	player.connect("update_menu", _update_menu)
	
	# Set initial inventory
	inventory_interface.set_player_inventory_data(player.inventory_data, 0)
	
	# Update tab menu
	_update_menu()

func _update_menu():
	perk_balance.text = "Perk Balance: " + str(player.perkBalance)
	hunger.text = "Hunger Level: " + str(player.hungerLvl)
func _on_scroll():
	player_inventory.highlight_slot(player.hotbar_pos)

func _update_inventory():
	inventory_interface.set_player_inventory_data(player.inventory_data, player.hotbar_pos)
	
func _process(_delta: float) -> void:
	pass
