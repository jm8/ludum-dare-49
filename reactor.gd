extends Spatial
	
var texture_time = 0.0

func _process(delta):
	if $Machine.is_active():
		$"reactor/Screen Light".light_color = Color.green
	else:
		$"reactor/Screen Light".light_color = Color.red
	
	
	texture_time += delta
	if texture_time > 1.0:
		texture_time -= 1.0
		
		$reactor.get_active_material(0).albedo_texture.current_frame = (1 + $reactor.get_active_material(0).albedo_texture.current_frame) % 8
	if !$Machine.is_active() && $reactor.get_active_material(0).albedo_texture.current_frame >= 4:
		$reactor.get_active_material(0).albedo_texture.current_frame = 0
	elif $Machine.is_active() && $reactor.get_active_material(0).albedo_texture.current_frame <= 3:
		$reactor.get_active_material(0).albedo_texture.current_frame = 4
