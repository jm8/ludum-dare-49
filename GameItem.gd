extends Area
class_name GameItem

export var item_name: String
var held_by

func attach_to(droid):
	held_by = droid
	$Mesh.scale = Vector3(.5,.5,.5)
	
func drop():
	held_by = null
	$Mesh.scale = Vector3(1.0,1.0,1.0)

func _process(delta):
	if held_by:
		global_transform = held_by.get_node("HoldPosition").global_transform
