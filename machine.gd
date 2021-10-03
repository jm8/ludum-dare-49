extends Node

export(Array) var recipes

var current_recipe: int = -1
var contents: Dictionary
export(Dictionary) var capacity


func _process(delta):
	var max_recipe: int = -1
	var max_delta: float = 0
	for i in range(recipes.size()):
		var recipe_delta = recipes[i].max_delta(delta, contents, capacity)
		if recipe_delta > max_delta:
			max_delta = recipe_delta
			max_recipe = i

	current_recipe = max_recipe

	if max_delta <= 0 || max_recipe == -1:
		return
	
	for input in recipes[max_recipe].inputs:
		contents[input] -= recipes[max_recipe].inputs[input] * max_delta
	for output in recipes[max_recipe]:
		contents[output] += recipes[max_recipe].outputs[output] * max_delta
		
	print(contents)
