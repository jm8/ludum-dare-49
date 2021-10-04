extends Node
class_name Machines

var machines = [
	{
		"name": "Conveyer",
		"node": preload("res://resources/models/machines/conveyer/conveyor.tscn"),
		"mesh": preload("res://resources/models/machines/conveyer/conveyor.obj"),
		"collision": null
	},
	{
		"name": "Sell Item Pad",
		"node": preload("res://scenes/SellItemPad.tscn"),
		"mesh": preload("res://resources/models/machines/item_pad/dropoff.obj"),
		"collision": preload("res://scenes/SellItemPadCollision.tres")
	},
	{
		"name": "Input Item Pad",
		"node": preload("res://scenes/InputItemPad.tscn"),
		"mesh": preload("res://resources/models/machines/item_pad/dropoff.obj"),
		"collision": preload("res://scenes/SellItemPadCollision.tres")
	},
	{
		"name": "Output Item Pad",
		"node": preload("res://scenes/OutputItemPad.tscn"),
		"mesh": preload("res://resources/models/machines/item_pad/dropoff.obj"),
		"collision": preload("res://scenes/SellItemPadCollision.tres")
	},
	{
		"name": "Mixer",
		"node": preload("res://scenes/mixer.tscn"),
		#"mesh": preload(),
		"collision": preload("res://scenes/SellItemPadCollision.tres")
	},
]
