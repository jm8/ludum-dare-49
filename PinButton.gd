extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _process(delta):
	if pressed:
		rect_rotation = -45.0
	else:
		rect_rotation = 0.0
