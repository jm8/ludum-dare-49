extends Spatial

func _process(delta):
	if $converyer and $OmniLight:
		if get_parent().get_node("Machine").is_active():
			$conveyer.get_active_material(0).albedo_texture.current_frame = 0
			$OmniLight.light_color = Color.green
		else:
			$conveyer.get_active_material(0).albedo_texture.current_frame = 1
			$OmniLight.light_color = Color.red
