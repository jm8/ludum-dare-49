extends Control

var price_graph_scene = preload("PriceGraph.tscn")
var menu_label_scene = preload("MenuLabel.tscn")
var initialized: bool = false


func _process(_delta):
	if not initialized:
		initialized = true
		for product in PriceManager.items:
			var graph = price_graph_scene.instance()
			graph.product_name = product
			graph.name = product
			graph.get_node("VBoxContainer/HBoxContainer/CenterContainer/PinButton").connect("toggled", self, "on_price_pinned", [product])
			$ScrollContainer/PriceGrid.add_child(graph)
		
	for child in $HUD/PinnedPrices.get_children():
		if child.name == "MenuLabel":
			continue
		child.text = "%s - %2.2f€" % [child.name, PriceManager.items[child.name].price() / 100.0]
	
	if Input.is_action_just_pressed("open_price_menu"):
		$ScrollContainer.visible = true
	if Input.is_action_just_pressed("close_price_menu"):
		$ScrollContainer.visible = false
		
	$"HUD/Top Bar/PowerMeter".value = Globals.power
	$"HUD/Top Bar/PowerMeter".max_value = Globals.power_max
	
	$"HUD/Top Bar/MoneyLabel".text = "%2.2f€" % (Globals.money / 100.0)
	

func on_price_pinned(button_pressed: bool, product: String):
	if button_pressed:
		var label = menu_label_scene.instance()
		label.name = product
		$HUD/PinnedPrices.add_child(label)
	else:
		$HUD/PinnedPrices.get_node(product).queue_free()



func _on_BuyMenuButton_pressed():
	$ScrollContainer.visible = true
