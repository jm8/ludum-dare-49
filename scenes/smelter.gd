extends Spatial

func _process(delta):
	$OmniLight.visible = $Machine.is_active()
