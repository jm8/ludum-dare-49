extends Area
class_name GameItem

export var item_name: String
var held_by

func attach_to(droid):
	held_by = droid
	$Mesh.scale = Vector3(.5,.5,.5)
	print(collision_layer)
	collision_layer = 4
	print(collision_layer)
	
func drop():
	held_by = null
	$Mesh.scale = Vector3(1.0,1.0,1.0)
	print(collision_layer)
	collision_layer = 1
	print(collision_layer)

func _process(_delta):
	if held_by:
		global_transform = held_by.get_node("HoldPosition").global_transform
