extends Spatial

func _on_StaticBody_area_entered(area):
	emit_signal("droid_can_drop", area.held_by, self)

func _on_StaticBody_area_exited(area):
	if area.collision_layer == 1:
		print("item dropped on pad")
		Globals.money += PriceManager.items[area.item_name].price()
		area.queue_free()
	else:
		emit_signal("droid_cannot_drop", area.held_by, self)


signal droid_can_drop(droid, dropoff)
signal droid_cannot_drop(droid, dropoff)

func _on_DroidDetectionAreaForText_body_entered(body):
	if body is Droid:
		if body.held_items.empty():
			emit_signal("droid_can_drop", body, self)
		
func _on_DroidDetectionAreaForText_body_exited(body):
	if body is Droid:
		if $StaticBody.get_overlapping_areas().empty():
			emit_signal("droid_cannot_drop", body, self)
