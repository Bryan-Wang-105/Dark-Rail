extends Control

var active_tab

@onready var supportPerks: Control = $Panel/Panel/SupportTab/Support/Control
@onready var support_tab: ColorRect = $Panel/Panel/SupportTab

@onready var durabilityPerks: Control = $Panel/Panel/DurabilityTab/Durability/Control
@onready var durability_tab: ColorRect = $Panel/Panel/DurabilityTab

@onready var combatPerks: Control = $Panel/Panel/CombatTab/Combat/Control
@onready var combat_tab: ColorRect = $Panel/Panel/CombatTab

@onready var scavengePerks: Control = $Panel/Panel/ScavengeTab/Scavenger/Control
@onready var scavenge_tab: ColorRect = $Panel/Panel/ScavengeTab


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
