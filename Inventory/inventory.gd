extends PanelContainer

const Slot = preload("res://Inventory/slot.tscn")

@onready var item_grid: GridContainer = $MarginContainer/ItemGrid

func set_inventory_data(inventory_data: InventoryData) -> void:
	populate_item_grid(inventory_data.slot_datas)


func populate_item_grid(slot_datas: Array[SlotData]) -> void:
	for child in item_grid.get_children():
		child.queue_free()
		
	for slot_data in slot_datas:
		var slot = Slot.instantiate()
		item_grid.add_child(slot)
		
		if slot_data:
			slot.set_slot_data(slot_data)

	pass

func highlight_slot(hotbar_pos: int) -> void:
	#print(item_grid.get_children())
	#print("\n")
	#var current_slot = item_grid.get_children()[hotbar_pos]
	#print(current_slot)
	#print(current_slot.get_property_list())
	#print(item_grid.get_children()[hotbar_pos].get_children())
	pass
