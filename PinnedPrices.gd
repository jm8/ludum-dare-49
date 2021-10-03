extends VBoxContainer


func _process(_delta):
	if get_child_count() > 1:
		$MenuLabel.visible = false
	else:
		$MenuLabel.visible = true

