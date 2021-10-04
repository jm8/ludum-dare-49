extends Label

func _ready():
	text = ""
	SignalBus.connect("held_items_changed", self, "_on_SignalBus_held_items_changed")

func _on_SignalBus_held_items_changed(new):
	var res = ""
	var join = ""
	for item in new:
		res += join + item.item_name
		join = "\n"
	text = res
