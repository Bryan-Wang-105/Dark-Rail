extends RigidBody3D

@export var slot_data: SlotData

var item = true
var prompt = null
var player
var world


func get_prompt(needSwap) -> String:
	if needSwap:
		prompt = "Press E for your random weapon"
	else:
		prompt = "Press E for your random weapon"

	return prompt

func interact(needSwap) -> SlotData:
	var itemsArr = get_tscn_files_in_directory()
	
	# Instantiate new item
	world = get_parent().get_parent()
	player = world.player
	
	# Get random item
	var random_number = randi_range(0,itemsArr.size()-1)
	print("Spawning ")
	print(itemsArr[random_number])
	
	#Spawn item
	var drop_item = load(itemsArr[random_number])
	var drop_node = drop_item.instantiate()
		
	# Spawn replaced item to the grabbed coordinates
	drop_node.position = position
	world.add_child(drop_node)
	
	return slot_data
	

static func use(player: CharacterBody3D):
	print("Pressed Button")

	# Will return true to signal (consume / destroy item)	
	return true

func get_tscn_files_in_directory():
	var files = []
	var dir = DirAccess.open("res://Item/item_assets/weapon_assets/")
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		while file_name != "":
			if file_name.contains(".tscn"):
				files.append("res://Item/item_assets/weapon_assets/" + file_name)

			file_name = dir.get_next()

		dir.list_dir_end()

	return files

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
