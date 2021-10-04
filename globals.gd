extends Node

var power: float = 1000
var power_max = 2000
var money = 100000
onready var scenes = {
	"Aluminum Beams": preload("res://items/AluminumBeams.tscn"),
	"Aluminum Ore": preload("res://items/AluminumOre.tscn"),
	"Aluminum Paint": preload("res://items/AluminumPaint.tscn"),
	"Aluminum Pipes": preload("res://items/AluminumPipes.tscn"),
	"Aluminum Sheets": preload("res://items/AluminumSheets.tscn"),
	"Copper Beams": preload("res://items/CopperBeams.tscn"),
	"Copper Ore": preload("res://items/CopperOre.tscn"),
	"Copper Paint": preload("res://items/CopperPaint.tscn"),
	"Copper Pipes": preload("res://items/CopperPipes.tscn"),
	"Copper Sheets": preload("res://items/CopperSheets.tscn"),
	"Iron Beams": preload("res://items/IronBeams.tscn"),
	"Iron Ore": preload("res://items/IronOre.tscn"),
	"Iron Pipes": preload("res://items/IronPipes.tscn"),
	"Iron Sheets": preload("res://items/IronSheets.tscn"),
	"Steel Beams": preload("res://items/SteelBeams.tscn"),
	"Steel Pipes": preload("res://items/SteelPipes.tscn"),
	"Steel Sheets": preload("res://items/SteelSheets.tscn"),
	"Water": preload("res://items/WaterBarrel.tscn"),
	"Contaminated Water": preload("res://items/ContaminatedWaterBarrel.tscn"),
	"Petroleum": preload("res://items/PetroleumTank.tscn"),
	"Carbon": preload("res://items/Carbon.tscn"),
	"Plastic": preload("res://items/Plastic.tscn"),
	"Uranium": preload("res://items/Uranium.tscn"),
	"Depleted Uranium": preload("res://items/DepletedUranium.tscn"),
	"Aluminum": preload("res://items/AluminumIngot.tscn"),
	"Copper": preload("res://items/CopperIngot.tscn"),
	"Iron": preload("res://items/IronIngot.tscn"),
	"Steel": preload("res://items/SteelIngot.tscn"),
	"Glass": preload("res://items/Glass.tscn"),
	"Circuit": preload("res://items/Circuit.tscn"),
	"Solar Panel": preload("res://items/SolarPanel.tscn"),
}



func add_power(amount: float):
	power = min(power_max, power + amount)

func remove_power(amount: float) -> bool:
	if amount >= power:
		power -= amount
		return true
	return false
