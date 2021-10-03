extends Node

var power: float = 1000
var power_max = 2000

func add_power(amount: float):
	power = min(power_max, power + amount)

func remove_power(amount: float) -> bool:
	if amount >= power:
		power -= amount
		return true
	return false
