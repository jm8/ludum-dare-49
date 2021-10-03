class_name Recipe
extends Resource

export(String) var recipe_name
export(Dictionary) var inputs
export(Dictionary) var outputs
export(float) var power

func max_delta(delta, contents: Dictionary, capacity:Dictionary) -> float:
	var max_delta = delta;
	for input in inputs:
		max_delta = min(max_delta, contents[input] / inputs[input]) 
		
	for output in outputs:
		max_delta = min(max_delta, (capacity[output] - contents[output]) / outputs[output])
		# machine uses power
		if power > 0:
			max_delta = min(max_delta, Globals.power / power)
		# machine generates power
		if power < 0:
			max_delta = min(max_delta, (Globals.power_max - Globals.power) / (-power))

	return max_delta
