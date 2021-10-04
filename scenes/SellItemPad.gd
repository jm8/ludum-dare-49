extends "res://scenes/AbstractDropoffPad.gd"

func dropoff(area):
	$AudioStreamPlayer3D.play()
	Globals.money += PriceManager.items[area.item_name].price()
	area.queue_free()
