extends RigidBody3D

#@onready var panel: Panel = $Panel
#@onready var perk_balance: Label = $Panel/PerkBalance
#@onready var fare: Label = $Panel/Fare

var player
var mark_menu_panel

var item = false
var panelVisible = false

signal update_menu

#func _ready() -> void:
	# Set panel to invisible
	#panel.visible = false

	# Update tab menu
	#_update_menu()

#func _update_menu():
	#player = $"../Player"
	#perk_balance.text = "Perk Balance: " + str(player.perkBalance)
	#fare.text = "Fare: $" + str(player.fare)

func get_prompt():
	return "Press E to browse wares"
	
func interact():
	toggle_tabVisible()
	
	print("In Store")

func toggle_tabVisible():
	emit_signal("update_menu")
	player = $"../Player"
	mark_menu_panel = $"../UI/MarketMenu/Panel"
	
	print(player.tabVisible)
	player.toggle_tabVisible()
	print(player.tabVisible)
	
	mark_menu_panel.visible = !mark_menu_panel.visible

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
