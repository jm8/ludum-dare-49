extends Control

var machine

func init(machine):
	self.machine = machine


func _process(delta):
	if not machine:
		return
	
	var object = machine.get_parent()
	var label_pos_obj = object.get_node("LabelPosition")
	var label_pos
	if label_pos_obj:
		label_pos = label_pos_obj.global_transform.origin
	else:
		label_pos = object.global_transform.origin + 2*Vector3.UP
	
	
	self.rect_global_position = get_viewport().get_camera().unproject_position(label_pos)
	
	$Label.text = machine.machine_name
	if machine.broken:
		$Label.set("custom_colors/font_color", Color.red)
		$Label.text += "\nBroken"
	else:
		$Label.set("custom_colors/font_color", Color.white)
		$Label.text += "\n" + String(machine.contents)
	
