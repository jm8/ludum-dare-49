extends "res://scenes/AbstractDropoffPad.gd"

func dropoff(area):
	if get_parent().get_node("Machine").add_item(area.item_name):
		area.queue_free()
	else:
		print("Invalid item put on plate")
