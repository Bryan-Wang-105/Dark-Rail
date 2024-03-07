extends CharacterBody3D

@onready var head: Node3D = $head
@export var inventory_data: InventoryData
@onready var hotbar_pos_lbl: Label = $hotbar_pos
@onready var item_lbl: Label = $item_lbl
@onready var interact_ray: RayCast3D = $head/interact_ray
@onready var camera: Camera3D = $head/Camera3D
@onready var panel: Panel = $"../UI/CharacterMenu/Panel"
@onready var hand: Node3D = $Hand

# Movement Vars
var SPEED = 5.0
const JUMP_VELOCITY = 4.5
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

# Signals
signal wheel_scroll
signal drop_item
signal update_inventory
signal update_menu

# Hotbar Vars
var hotbar_pos = 0
var current_slot = null

# Camera stuff
var capMouse = false
var direction = Vector3.ZERO
var mouse_sens = .0015
var lerp_speed = 10.0

# Tab Menu vars
var tabVisible = false
var perkBalance = 1
var hungerLvl = 50
var fare = 0

func _ready() -> void:
	#inventory_interface.set_player_inventory_data(inventory_data)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	# update inventory signal
	interact_ray.connect("update_inventory", call_update)

func _input(event):
	if event is InputEventMouseMotion and tabVisible == false:
		rotate_y(-event.relative.x * mouse_sens)
		head.rotate_x(-event.relative.y * mouse_sens)
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-85),deg_to_rad(85))

func _physics_process(delta: float) -> void:
	# Define current selected item on hotbar
	current_slot = inventory_data.slot_datas[hotbar_pos]
	
	# UI UNTIL HIGHLIGHTING WORKS
	hotbar_pos_lbl.text = "Hotbar Position = " + str(hotbar_pos)
	if current_slot:
		item_lbl.text = "Item at Position = " + str(current_slot.item_data.name)
	else:
		item_lbl.text = "Item at Position = EMPTY"
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle see inventory.
	if Input.is_action_just_pressed("tab"):
		tab_menu()
		
		print("Current Inventory:")
		print(hotbar_pos)
		print(inventory_data.slot_datas)
		if current_slot:
			print(current_slot.item_data.name)
		else:
			print("EMPTY")

		# Only do movement if not in tab menu
	if tabVisible == false:
		# Handle use item
		if Input.is_action_just_pressed("use"):
			if current_slot:
				var use_item = load(current_slot.item_data.pathToScript)
				
				# if item should be destroyed
				if use_item.use(self):
					inventory_data.slot_datas[hotbar_pos] = null
					emit_signal("update_inventory")
				else:
					pass
		
		# Handle drop.
		if Input.is_action_just_pressed("drop"):
			print("Dropping current item")
			
			if current_slot:
				var toDrop_item = load(current_slot.item_data.pathToAsset)
				var toDrop_node = toDrop_item.instantiate()
				toDrop_node.position = interact_ray.get_drop_position()

				# Get the camera's transform
				var camera_transform = camera.global_transform

				# Get the camera's forward vector (direction it is facing)
				var camera_direction = -camera_transform.basis.z.normalized()
				toDrop_node.linear_velocity = (camera_direction * 3) + (.65 * velocity)
				
				get_parent().add_child(toDrop_node)
			
				inventory_data.slot_datas[hotbar_pos] = null
				emit_signal("update_inventory")

		# Scrolling
		if Input.is_action_just_pressed("scroll_up"):
			hotbar_pos += 1
			if hotbar_pos > 5:
				hotbar_pos = 0
			
			current_slot = inventory_data.slot_datas[hotbar_pos]
			
			print("\nHotbar Position: %s" % [hotbar_pos])
			if current_slot:
				print("Item at slot: %s" % current_slot.item_data.name)
			else:
				print("Item at slot: EMPTY")
			
			emit_signal("wheel_scroll")

		if Input.is_action_just_pressed("scroll_down"):
			hotbar_pos -= 1
			if hotbar_pos < 0:
				hotbar_pos = 5
			
			current_slot = inventory_data.slot_datas[hotbar_pos]
			
			print("\nHotbar Position: %s" % [hotbar_pos])
			
			if current_slot:
				print("Item at slot: %s" % current_slot.item_data.name)
			else:
				print("Item at slot: EMPTY")
				
			emit_signal("wheel_scroll")

		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		 
		# Handle sprint
		if Input.is_action_pressed("sprint") and is_on_floor():
			SPEED = 8
			
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		direction = lerp(direction, (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(), delta*lerp_speed)
			
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)

	if Input.is_action_just_pressed("pause"):
		if tabVisible:
			var world = get_parent()
			world._exit_screen()
			toggle_tabVisible()
			print("Close Menu")
		else:
			get_tree().quit()

	move_and_slide()

func call_update():
	emit_signal("update_inventory")

func tab_menu():
	# Don't show menu if another menu is up
	if tabVisible:
		if panel.visible:
			panel.visible = !tabVisible
			toggle_tabVisible()
		
		
	else:
		emit_signal("update_menu")
		print("A")
		print(tabVisible)
		panel.visible = !tabVisible
		toggle_tabVisible()
	
	pass

# Handle mouse capturing logic
func toggle_tabVisible():
	print("B")
	print(tabVisible)
	tabVisible = !tabVisible

	print(tabVisible)

	if tabVisible:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
		velocity = Vector3(0,velocity.y,0)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func setHungerLvl(amount):
	hungerLvl += amount
	emit_signal("update_menu")

func getHungerLvl():
	#emit_signal("update_menu")
	return hungerLvl

func setFare(amount):
	fare += amount
	emit_signal("update_menu")

func getFare():
	#emit_signal("update_menu")
	return fare

func setPerkBalance(amount):
	perkBalance += amount
	emit_signal("update_menu")

func getPerkBalance():
	#emit_signal("update_menu")
	return perkBalance
