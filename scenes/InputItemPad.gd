extends Spatial


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_StaticBody_area_exited(area):
	if area.collision_layer == 1:
		if get_parent().get_node("Machine").add_item(area.item_name):
			area.queue_free()
		else:
			print("Invalid item put on plate")


## Droid detection (for text)
signal droid_can_drop(droid, dropoff)
signal droid_cannot_drop(droid, dropoff)

func _on_DroidDetectionAreaForText_body_entered(body):
	if body is Droid:
		emit_signal("droid_can_drop", body, self)


func _on_DroidDetectionAreaForText_body_exited(body):
	if body is Droid:
		emit_signal("droid_cannot_drop", body, self)
