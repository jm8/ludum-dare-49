extends Spatial

func _process(delta):
	if get_parent().get_node("Machine").is_active():
		$conveyor.get_active_material(0).albedo_texture.current_frame = 1
		$OmniLight.light_color = Color.green
	else:
		$conveyor.get_active_material(0).albedo_texture.current_frame = 0
		$OmniLight.light_color = Color.red
