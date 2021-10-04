extends Camera


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _exit_tree():
	print(get_viewport().transparent_bg)
	var image = get_viewport().get_texture().get_data()
	image.convert(Image.FORMAT_RGBA8)
	image.flip_y()
	image.save_png("D:/projects/ludum-dare-49/img.png")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
