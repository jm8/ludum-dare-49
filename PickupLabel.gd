extends Label

var item
var format = "%s (press E)"

func _process(delta):
	if item != null:
		rect_global_position = get_viewport().get_camera().unproject_position(item.global_transform.origin)
		
		

func _on_Droid_can_pick_up(new_item):
	item = new_item
	text = format % [item.item_name]
	visible = true


func _on_Droid_cannot_pick_up(new_item):
	item = null
	visible = false
