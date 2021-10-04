extends Label

var sell_format = "Sell %s for €%.2f"
var no_sell_format = "Nothing to sell"

var input_format = "Add %s to %s"
var bad_input_format = "Can't add %s to %s"
var no_input_format = "Nothing to add"

var current_pad = null
var droid = null

const SellItemPad = preload("res://scenes/SellItemPad.gd")
const InputItemPad = preload("res://scenes/InputItemPad.gd")

func _ready():
	SignalBus.connect("droid_can_drop", self, "_on_SignalBus_droid_can_drop")
	SignalBus.connect("droid_cannot_drop", self, "_on_SignalBus_droid_cannot_drop")

func _process(_delta):
	if current_pad != null:
		rect_global_position = get_viewport().get_camera().unproject_position(current_pad.global_transform.origin)
		if len(droid.held_items) == 0:
			set("custom_colors/font_color", Color.red)
			if current_pad is SellItemPad:
				text = no_sell_format
			else:
				text = no_input_format
		else:
			
			if current_pad is SellItemPad:
				var item = droid.held_items[len(droid.held_items)-1]
				var price = PriceManager.items[item.item_name].price() / 100.0
				text = sell_format % [item.item_name, price]
			else:
				var item = droid.held_items[len(droid.held_items)-1]
				var machine = current_pad.get_parent().get_node("Machine")
				if machine.has_input(item.item_name):
					set("custom_colors/font_color", Color.white)
					text = input_format % [item.item_name, machine.machine_name]
				else:
					set("custom_colors/font_color", Color.red)
					text = bad_input_format % [item.item_name, machine.machine_name]

func _on_SignalBus_droid_can_drop(droid, dropoff):
	print("Yo signal!")
	current_pad = dropoff
	self.droid = droid
	visible = true


func _on_SignalBus_droid_cannot_drop(droid, dropoff):
	current_pad = null
	visible = false
