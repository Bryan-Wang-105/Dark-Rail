extends RayCast3D

@onready var prompt = $Prompt
@onready var player: CharacterBody3D = $"../.."
@onready var camera: Camera3D = $"../Camera3D"

signal update_inventory

var needSwap = null
var wasItem = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_exception(owner)
	prompt.text = ""
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#if player.tabVisible == false:
		if is_colliding():
			var interactable = get_collider()
			#print(interactable)
			#print(interactable.name)
			
			if interactable != null and interactable.has_method("interact"):
				needSwap = (player.current_slot != null)
				
				if interactable.item:
					prompt.text = interactable.get_prompt(needSwap)
					
					if Input.is_action_just_pressed("interact"):
						wasItem = interactable.interact(needSwap)
						
						if wasItem:
							player.inventory_data.slot_datas[player.hotbar_pos] = wasItem
							player.current_slot = wasItem
							emit_signal("update_inventory")
				else:
					prompt.text = interactable.get_prompt()
					if Input.is_action_just_pressed("interact"):
						interactable.interact()
						
			else:
				prompt.text = ""
			
		else:
			prompt.text = ""
		
func get_drop_position():
	var direction = -camera.global_transform.basis.z
	
	return camera.global_position + direction
