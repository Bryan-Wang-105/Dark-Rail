extends RigidBody3D

@export var slot_data: SlotData

var prompt = null
var player
var world

func get_prompt(needSwap) -> String:
	if needSwap:
		prompt = "Press E to swap item for " + slot_data.item_data.name
	else:
		prompt = "Press E to pick up " + slot_data.item_data.name
		
	return prompt

func interact(needSwap) -> SlotData:
	if needSwap:
		# free item
		queue_free()
		
		# Instantiate new item
		world = get_parent()
		player = world.player
	
		var drop_item = load(player.current_slot.item_data.pathToAsset)
		var drop_node = drop_item.instantiate()
		
		# Spawn replaced item to the grabbed coordinates
		drop_node.position = position
		world.add_child(drop_node)

	else:
		print("Picked up this Kings Coin!")
		queue_free()
	
	return slot_data

static func use(player: CharacterBody3D):
	print("Cashed in one perk point")
	player.perkBalance += 1

	# Will return true to signal (consume / destroy item)	
	return true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass