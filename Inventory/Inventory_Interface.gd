extends Control

@onready var player_inventory: PanelContainer = $PlayerInventory
@onready var player: CharacterBody3D = $"../../Player"

signal drop_item(item: SlotData)

func set_player_inventory_data(inventory_data: InventoryData) -> void:
	player_inventory.set_inventory_data(inventory_data)

func _ready() -> void:
	player.connect("drop_item", _drop_item)


func _drop_item():
	print("Dropped Item")
