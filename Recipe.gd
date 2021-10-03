class_name Recipe
extends Resource

export(String) var recipe_name
export(Dictionary) var inputs
export(Dictionary) var outputs

func max_delta(delta, contents: Dictionary, capacity:Dictionary) -> float:
	var max_delta = delta;
	for input in inputs:
		max_delta = min(max_delta, contents[input] / inputs[input]) 
		
	for output in outputs:
		max_delta = min(max_delta, (capacity[output] - contents[output]) / outputs[output])
	return max_delta
