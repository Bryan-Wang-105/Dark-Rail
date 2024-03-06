extends PanelContainer

@onready var texture_rect: TextureRect = $MarginContainer/TextureRect
@onready var quantity: Label = $Quantity



func set_slot_data(slot_data: SlotData) -> void:
	var item_data = slot_data.item_data
	texture_rect.texture = item_data.texture
	
	tooltip_text = "%s\n%s" % [item_data.name, item_data.description]
	
	if slot_data.quantity > 1 and slot_data.item_data.stackable:
		quantity.text = "x%s" % slot_data.quantity
		quantity.show()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
