extends Node

export(Array) var recipes
export(float) var speed = 0.2

var current_recipe: int = -1
var contents: Dictionary
var timer = 0.0
var broken: bool

export(Dictionary) var capacity

func _ready():
	for item in capacity:
		contents[item] = 0.0

func is_active():
	return (!broken) && current_recipe != -1

func has_input(item: String) -> bool:
	for recipe in recipes:
		if recipe.inputs.has(item):
			return true
	return false
	
func add_item(item: String) -> bool:
	if !has_input(item):
		return false
	if capacity[item] - contents[item] >= 1.0:
		contents[item] += 1.0
		return true
	return false

func get_outputs() -> Array:
	var arr = Array()
	for recipe in recipes:
		arr.append_array(recipe.outputs.keys())
	return arr


func _process(frame_delta):
	timer += frame_delta
	if timer > 0.5:
		timer -= 0.5
		if !broken && rand_range(0.0, 1.0) < 0.05:
			print("Machine broken!")
			broken = true
	var particles = get_parent().get_node("particles")
	if particles:
		particles.visible = broken

	var delta = frame_delta * speed
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
