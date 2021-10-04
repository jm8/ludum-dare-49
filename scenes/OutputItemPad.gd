extends Spatial


func _process(_delta):
	for item in get_parent().get_node("Machine").get_outputs():
		if get_parent().get_node("Machine").contents[item] >= 1.0:
			get_parent().get_node("Machine").contents[item] -= 1.0
			var object = Globals.scenes[item].instance()
			get_tree().current_scene.add_child(object)
			object.global_transform.origin = $"Spawn Point".global_transform.origin
			object.translation += Vector3(rand_range(-0.5, 0.5), 0.0, rand_range(-0.5, 0.5))
