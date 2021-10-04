extends Label

var sell_format = "Sell %s for €%.2f"
var no_sell_format = "Nothing to sell"

var current_pad = null
var droid = null

func _process(_delta):
	if current_pad != null:
		rect_global_position = get_viewport().get_camera().unproject_position(current_pad.global_transform.origin)
		if len(droid.held_items) == 0:
			set("custom_colors/font_color", Color.red)
			text = no_sell_format
		else:
			set("custom_colors/font_color", Color.white)
			var item = droid.held_items[len(droid.held_items)-1]
			var price = PriceManager.items[item.item_name].price() / 100.0
			text = sell_format % [item.item_name, price]

func _on_SellItemPad_droid_can_drop(new_droid, dropoff):
	current_pad = dropoff
	droid = new_droid
	visible = true

func _on_SellItemPad_droid_cannot_drop(droid, dropoff):
	current_pad = null
	visible = false
