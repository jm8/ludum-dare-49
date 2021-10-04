extends Spatial

func dropoff(area):
	pass

func _on_StaticBody_area_entered(area):
	print("droid_can_drop")
	SignalBus.emit_signal("droid_can_drop", area.held_by, self)

func _on_StaticBody_area_exited(area):
	if area.collision_layer == 1:
		dropoff(area)
	else:
		SignalBus.emit_signal("droid_cannot_drop", area.held_by, self)


func _on_DroidDetectionAreaForText_body_entered(body):
	if body is Droid:
		if body.held_items.empty():
			SignalBus.emit_signal("droid_can_drop", body, self)
		
func _on_DroidDetectionAreaForText_body_exited(body):
	if body is Droid:
		if $StaticBody.get_overlapping_areas().empty():
			SignalBus.emit_signal("droid_cannot_drop", body, self)
