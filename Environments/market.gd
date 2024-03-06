extends RigidBody3D

@onready var panel: Panel = $Panel
@onready var perk_balance: Label = $Panel/PerkBalance
@onready var fare: Label = $Panel/Fare

var player
var item = false
var panelVisible = false

func _ready() -> void:
	# Set panel to invisible
	panel.visible = false

	# Update tab menu
	_update_menu()

func _update_menu():
	player = $"../Player"
	perk_balance.text = "Perk Balance: " + str(player.perkBalance)
	fare.text = "Fare: $" + str(player.fare)

func get_prompt():
	return "Press E to browse wares"
	
func interact():
	print(player.tabVisible)
	player.toggle_tabVisible()
	print(player.tabVisible)
	
	panel.visible = !panelVisible
	panelVisible = !panelVisible
	
	print("In Store")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
