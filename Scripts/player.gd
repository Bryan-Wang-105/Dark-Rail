extends CharacterBody3D

@onready var head: Node3D = $head
@export var inventory_data: InventoryData


var SPEED = 5.0
const JUMP_VELOCITY = 4.5

signal wheel_scroll
var hotbar_pos = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var direction = Vector3.ZERO
var mouse_sens = .0015
var lerp_speed = 10.0

var capMouse = false

func _ready() -> void:
	#inventory_interface.set_player_inventory_data(inventory_data)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sens)
		head.rotate_x(-event.relative.y * mouse_sens)
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-85),deg_to_rad(85))

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

		# Handle jump.
	if Input.is_action_just_pressed("tab"):
		print("Current Inventory:")
		print(inventory_data.slot_datas)

	if Input.is_action_just_pressed("scroll_up"):
		hotbar_pos += 1
		if hotbar_pos > 5:
			hotbar_pos = 0
		
		print("\nHotbar Position: %s -- Item at slot: %s" % [hotbar_pos, inventory_data.slot_datas[hotbar_pos]])
		if inventory_data.slot_datas[hotbar_pos]:
			print(inventory_data.slot_datas[hotbar_pos].item_data.name)
		
		emit_signal("wheel_scroll")

	if Input.is_action_just_pressed("scroll_down"):
		hotbar_pos -= 1
		if hotbar_pos < 0:
			hotbar_pos = 5
		
		print("\nHotbar Position: %s -- Item at slot: %s" % [hotbar_pos, inventory_data.slot_datas[hotbar_pos]])
		if inventory_data.slot_datas[hotbar_pos]:
			print(inventory_data.slot_datas[hotbar_pos].item_data.name)
			
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
		get_tree().quit()

	move_and_slide()
