extends Spatial


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_StaticBody_area_exited(area):
	if area.collision_layer == 1:
		print("item dropped on pad")
		Globals.money += PriceManager.items[area.item_name].price()
		area.queue_free()
