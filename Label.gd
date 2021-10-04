extends Label

func _process(_delta):
	if visible:
		var pos = $"/root/World/Droid".global_transform.origin
		var gridpos = $"/root/World/GridMap".world_to_map(pos)
		text = String(gridpos)
