extends TextureButton

func _process(_delta):
	if pressed:
		rect_rotation = -45.0
	else:
		rect_rotation = 0.0
