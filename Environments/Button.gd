extends MeshInstance3D

var item = false
var prompt = null
var player
var world

func get_prompt(needSwap) -> String:
	prompt = "Press E to move"
		
	return prompt

func interact(needSwap):
	print("Moving now on train!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
