extends Spatial

func _process(_delta):
	$OmniLight.visible = $Machine.is_active()
	print($Machine.contents["Iron"])
