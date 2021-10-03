extends Camera

onready var droid = $"../Droid"
onready var offset = global_transform.origin - droid.global_transform.origin

func _process(delta):
	var newpos = droid.global_transform.origin + offset
	global_transform.origin.x = lerp(global_transform.origin.x, newpos.x, 0.2)
	global_transform.origin.z = lerp(global_transform.origin.z, newpos.z, 0.2)
	
