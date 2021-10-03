extends Spatial


# Called when the node enters the scene tree for the first time.
func _ready():
	$reactor/Machine.contents["Uranium"] = 8
	$reactor/Machine.contents["Water"] = 8
	
var texture_time = 0.0

func _process(delta):
	if $reactor/Machine.is_active():
		$"reactor/Screen Light".light_color = Color.green
	else:
		$"reactor/Screen Light".light_color = Color.red
	
	
	texture_time += delta
	if texture_time > 1.0:
		texture_time -= 1.0
		
		$reactor.get_active_material(0).albedo_texture.current_frame = (1 + $reactor.get_active_material(0).albedo_texture.current_frame) % 8
	if !$reactor/Machine.is_active() && $reactor.get_active_material(0).albedo_texture.current_frame >= 4:
		$reactor.get_active_material(0).albedo_texture.current_frame = 0
	elif $reactor/Machine.is_active() && $reactor.get_active_material(0).albedo_texture.current_frame <= 3:
		$reactor.get_active_material(0).albedo_texture.current_frame = 4
