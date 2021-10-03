extends Node

export(Dictionary) var inputs
export(Dictionary) var outputs

var contents: Dictionary
export(Dictionary) var capacity

func _ready():
	assert(capacity.has_all(inputs.keys()))
	assert(capacity.has_all(outputs.keys()))
	for i in capacity:
		contents[i] = 0.0
	contents["Iron"] = 6.0


func _process(delta):
	var max_delta = delta;
	
	for input in inputs:
		max_delta = min(max_delta, contents[input] / inputs[input]) 
		
	for output in outputs:
		max_delta = min(max_delta, (capacity[output] - contents[output]) / outputs[output])

	for input in inputs:
		contents[input] -= inputs[input] * max_delta
	for output in outputs:
		contents[output] += outputs[output] * max_delta
		
	print(contents)
