extends Camera

onready var droid = $"../Droid/RigidBody"
onready var offset = global_transform.origin - droid.global_transform.origin

func _process(delta):
	var newpos = droid.global_transform.origin + offset
	global_transform.origin.x = newpos.x
	global_transform.origin.z = newpos.z
	
