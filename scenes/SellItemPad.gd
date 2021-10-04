extends "res://scenes/AbstractDropoffPad.gd"

func dropoff(area):
	Globals.money += PriceManager.items[area.item_name].price()
	area.queue_free()
