extends Label

var item
var format = "%s (press E)"
var too_full_format = "can't pick up %s (too full)"

func _process(delta):
	if item != null:
		rect_global_position = get_viewport().get_camera().unproject_position(item.global_transform.origin)
		

func _on_Droid_can_pick_up(new_item):
	item = new_item
	text = format % [item.item_name]
	set("custom_colors/font_color", Color.white)
	visible = true


func _on_Droid_cannot_pick_up(new_item):
	item = null
	visible = false


func _on_Droid_too_full_to_pick_up(new_item):
	item = new_item
	text = too_full_format % [item.name]
	set("custom_colors/font_color", Color.red)
	visible = true
