extends Node3D
@onready var player: CharacterBody3D = $Player
@onready var inventory_interface: Control = $UI/InventoryInterface
@onready var player_inventory: PanelContainer = $UI/InventoryInterface/PlayerInventory

func _ready() -> void:
	# Connect signal to inventory UI
	player.connect("wheel_scroll", _on_scroll)
	inventory_interface.set_player_inventory_data(player.inventory_data)

func _on_scroll():
	print("Going to change color")
	player_inventory.highlight_slot(player.hotbar_pos)
