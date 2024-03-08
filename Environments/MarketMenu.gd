extends Control

var active_tab
var world
var player

var cost
var index

@onready var supportPerks: Control = $Panel/Panel/SupportTab/Support/Control
@onready var support_tab: ColorRect = $Panel/Panel/SupportTab

@onready var durabilityPerks: Control = $Panel/Panel/DurabilityTab/Durability/Control
@onready var durability_tab: ColorRect = $Panel/Panel/DurabilityTab

@onready var combatPerks: Control = $Panel/Panel/CombatTab/Combat/Control
@onready var combat_tab: ColorRect = $Panel/Panel/CombatTab


@onready var scavengePerks: Control = $Panel/Panel/ScavengeTab/Scavenger/Control
@onready var scavenge_tab: ColorRect = $Panel/Panel/ScavengeTab
@onready var scavenge_panel: Panel = $Panel/Panel/ScavengeTab/Scavenger/Control/PerkOne/Panel
@onready var scavenge_panel1: Panel = $Panel/Panel/ScavengeTab/Scavenger/Control/PerkTwo/Panel
@onready var scavenge_panel2: Panel = $Panel/Panel/ScavengeTab/Scavenger/Control/PerkThree/Panel
@onready var scavenge_button2: Button = $Panel/Panel/ScavengeTab/Scavenger/Control/PerkThree/PerkThreeButton
@onready var scavenge_panel3: Panel = $Panel/Panel/ScavengeTab/Scavenger/Control/PerkFour/Panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	active_tab = 0
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_support_button_pressed() -> void:
	change_tab(3)
	pass # Replace with function body.

func _on_durability_button_pressed() -> void:
	change_tab(2)
	pass # Replace with function body.
	
func _on_combat_button_pressed() -> void:
	change_tab(1)
	pass # Replace with function body.
	
func _on_scavenge_button_pressed() -> void:
	change_tab(0)
	pass # Replace with function body.	

func change_tab(changeActiveTabTo):
	#Deactivate old tab
	if active_tab == 0:
		scavengePerks.visible = false
		scavenge_tab.color.a = .509
		
	elif active_tab == 1:
		combatPerks.visible = false
		combat_tab.color.a = .509
		
	elif active_tab == 2:
		durabilityPerks.visible = false
		durability_tab.color.a = .509
	else:
		supportPerks.visible = false
		support_tab.color.a = .509

	# activate new tab
	if changeActiveTabTo == 0:
		scavengePerks.visible = true
		scavenge_tab.color.a = 1
		active_tab = 0
		
	elif changeActiveTabTo == 1:
		combatPerks.visible = true
		combat_tab.color.a = 1
		active_tab = 1
		
	elif changeActiveTabTo == 2:
		durabilityPerks.visible = true
		durability_tab.color.a = 1
		active_tab = 2
	else:
		supportPerks.visible = true
		support_tab.color.a = 1
		active_tab = 3


func _on_scavenge_mouse_entered() -> void:
	scavenge_panel.visible = true
	pass # Replace with function body.
func _on_scavenge_mouse_exited() -> void:
	scavenge_panel.visible = false
	pass # Replace with function body.

func _on_scavenge1_mouse_entered() -> void:
	scavenge_panel1.visible = true
	pass # Replace with function body.
func _on_scavenge1_mouse_exited() -> void:
	scavenge_panel1.visible = false
	pass # Replace with function body.

func _on_scavenge2_mouse_entered() -> void:
	scavenge_panel2.visible = true
	pass # Replace with function body.
func _on_scavenge2_mouse_exited() -> void:
	scavenge_panel2.visible = false
	pass # Replace with function body.

func _on_scavenge3_mouse_entered() -> void:
	scavenge_panel3.visible = true
	pass # Replace with function body.

func _on_scavenge3_mouse_exited() -> void:
	scavenge_panel3.visible = false
	pass # Replace with function body.

func _scavenge2_button_pressed() -> void:
	cost = 1
	index = 2
	
	world = get_parent().get_parent()
	player = get_parent().get_parent().player
	player.print_stats()
	
	if player.getPerkBalance() >= 1:
		player.setPerkBalance(-cost)
		player.setPerkActive(index)
		world._update_menus()
		scavenge_button2.text = "Active"

	else:
		pass
	
	pass # Replace with function body.
