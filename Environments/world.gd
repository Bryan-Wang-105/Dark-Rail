extends Node3D
@onready var player: CharacterBody3D = $Player
@onready var inventory_interface: Control = $UI/InventoryInterface
@onready var player_inventory: PanelContainer = $UI/InventoryInterface/PlayerInventory

func _ready() -> void:
	# Scroll wheel signal
	player.connect("wheel_scroll", _on_scroll)
	
	# Update inventory signal
	player.connect("update_inventory", _update_inventory)
	
	# Set initial inventory
	inventory_interface.set_player_inventory_data(player.inventory_data, 0)

func _on_scroll():
	player_inventory.highlight_slot(player.hotbar_pos, player.inventory_data)

func _update_inventory():
	inventory_interface.set_player_inventory_data(player.inventory_data, player.hotbar_pos)
	
func _process(delta: float) -> void:
	pass
