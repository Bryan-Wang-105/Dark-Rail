extends RigidBody3D

@export var slot_data: SlotData

var item = true
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
		print("Picked up this torch!")
		queue_free()
	
	return slot_data
	

func use(player: CharacterBody3D):
	if player.interact_ray.is_colliding():
		
		var interactable = player.interact_ray.get_collider()
		
		if interactable is StaticBody3D:
			print(interactable)
			
			# Clear hand
			player.clear_hand(player.hotbar_pos)
			
			# Get point of collision
			print("CollisionPoint:")
			var collision_point = player.interact_ray.get_collision_point()
			
			# Get the start position of the ray
			var ray_start = player.interact_ray.get_global_transform().origin

			# Calculate the direction vector of the ray
			var ray_direction = (collision_point - ray_start).normalized()

			# Determine the distance you want to offset before the collision point
			var offset_distance = .025 # Adjust this value as needed

			# Calculate the new position slightly before the collision point
			var offset_position = collision_point - ray_direction * offset_distance
			spawn_torch(offset_position)

func spawn_torch(position):
	# Instantiate the torch scene
	#var torch_instance = torch_scene.instance()
	# Set the torch's position to the collision point
	#torch_instance.global_transform.origin = position
	# Add the torch to the scene
	#add_child(torch_instance)
	world = get_parent().get_parent().get_parent().get_parent()
	print(world)
	
	var toDrop_item = load(slot_data.item_data.pathToAsset)
	var toDrop_node = toDrop_item.instantiate()
	toDrop_node.position = position
	toDrop_node.freeze = true
	
	world.add_child(toDrop_node)


	# Will return true to signal (consume / destroy item)	
	return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
