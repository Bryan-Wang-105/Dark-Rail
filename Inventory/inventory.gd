extends PanelContainer

const Slot = preload("res://Inventory/slot.tscn")

@onready var item_grid: GridContainer = $MarginContainer/ItemGrid
#@onready var player_hand: Node3D = $"../../../Player/Head/Hand"

var player
var player_hand
var index
var held_node
var held_item
var item_collider

func set_inventory_data(inventory_data: InventoryData, hotbar_pos: int) -> void:
	populate_item_grid(inventory_data.slot_datas, hotbar_pos)

func populate_item_grid(slot_datas: Array[SlotData], hotbar_pos: int) -> void:
	index = 0
	
	for child in item_grid.get_children():
		child.queue_free()
	
	for slot_data in slot_datas:
		var slot = Slot.instantiate()
		item_grid.add_child(slot)
		
		if index == hotbar_pos:
			# Must spawn new stylebox
			var new_style = StyleBoxFlat.new()
			
			# Must have floats in terms of RGB # / 255, opacity
			new_style.bg_color = Color(0.372, 0.721, 0.839, .5)
			
			# Set the new style
			slot.set("theme_override_styles/panel", new_style)
		
		if slot_data:
			slot.set_slot_data(slot_data)
		
		index += 1

func highlight_slot(hotbar_pos: int) -> void:
	var left
	var right
	
	# Get left and right slots to check if it's highlighted
	if hotbar_pos == 5:
		left = 4
		right = 0
	elif hotbar_pos == 0:
		left = 5
		right = 1
	else:
		left = hotbar_pos-1
		right = hotbar_pos+1
	
	# Get the current slot of interest
	var slot = item_grid.get_child(hotbar_pos)
	
	# Unhighlight left/right side hotbar position 
	if item_grid.get_child(left).get("theme_override_styles/panel"):
		item_grid.get_child(left).set("theme_override_styles/panel", null)
	else:
		item_grid.get_child(right).set("theme_override_styles/panel", null)

	# Must spawn new stylebox
	var new_style = StyleBoxFlat.new()
	
	# Must have floats in terms of RGB # / 255, opacity
	new_style.bg_color = Color(0.372, 0.721, 0.839, .5)
	
	# Set the new style
	slot.set("theme_override_styles/panel", new_style)
	pass

func showItemInHand():
	print("\nUpdating hand")
	player = get_parent().get_parent().get_parent().player
	player_hand = player.hand
	
	# Clear current hand item
	for child in player_hand.get_children():
		child.queue_free()

	#print(player.current_slot.item_data.name)
	print(player.hotbar_pos)
	print(player.current_slot)
	
	if player.current_slot:
		print("show")
		print(player.current_slot.item_data.name)
		print(player.current_slot.item_data.pathToAsset)
	
		# Configure the item node
		var held_item = load(player.current_slot.item_data.pathToAsset)
		var held_node = held_item.instantiate()
		
		# Configure item position and traits
		held_node.position = player.hand.position
		held_node.freeze = true
		# disable colliders on item in hand
		held_node.process_mode = Node.PROCESS_MODE_DISABLED

		# Spawn the item to players hand
		player_hand.add_child(held_node)
	
	else:
		print("Emptying!!!")
		# Clear current hand item
		for child in player_hand.get_children():
			child.queue_free()
	
	print("\n")
