extends Node

export(Array) var recipes

var current_recipe: int = -1
var contents: Dictionary
export(Dictionary) var capacity

func _ready():
	for item in capacity:
		contents[item] = 0.0

func is_active():
	return current_recipe != -1


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
	for output in recipes[max_recipe].outputs:
		contents[output] += recipes[max_recipe].outputs[output] * max_delta
	Globals.power -= recipes[max_recipe].power * max_delta
