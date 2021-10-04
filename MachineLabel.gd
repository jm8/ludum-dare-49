extends VBoxContainer

var machine

var bars = {}

func init(machine):
	self.machine = machine
	for name in machine.capacity.keys():
		var label = Label.new()
		label.text = name
		$GridContainer.add_child(label)
		var progressbar = ProgressBar.new()
		bars[name] = progressbar
		$GridContainer.add_child(progressbar)

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
		for item in machine.contents:
			bars[item].value = 100 * machine.contents[item] / machine.capacity[item]
