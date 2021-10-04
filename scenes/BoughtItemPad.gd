extends Spatial


# Called when the node enters the scene tree for the first time.
func add_item(item_name: String):
	var object = Globals.scenes[item_name].instance()
	get_tree().current_scene.add_child(object)
	object.global_transform.origin = $"Spawn Point".global_transform.origin
	object.translation += Vector3(rand_range(-0.5, 0.5), 0.0, rand_range(-0.5, 0.5))
