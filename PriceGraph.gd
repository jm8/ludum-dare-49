extends Control

var product_name: String

onready var line_control_node = $VBoxContainer/MarginContainer/HBoxContainer/Control/LineControl

func _ready():
	#if PriceManager.items[product_name].sellable:
		#$VBoxContainer/HBoxContainer/MarginContainer/BuyButton.visible = false
	#else:
	$VBoxContainer/HBoxContainer/MarginContainer/BuyButton.visible = false
	


func _process(_delta):
	var margin = $VBoxContainer/MarginContainer/HBoxContainer/Control/LineContainer/Control.rect_size.y / 2.0
	$VBoxContainer/MarginContainer/HBoxContainer/Control/LineControl.margin_bottom = -margin
	$VBoxContainer/MarginContainer/HBoxContainer/Control/LineControl.margin_top = margin
	
	
	for product in PriceManager.items:
		var values = product..prices
		if values.size() <= 1:
			return

		# get highest price (for scaling
		var max_val: int = 0
		max_val = 10000
		#for value in values:
	#		if value > max_val:
	#			max_val = value

		# set price lines
		$VBoxContainer/MarginContainer/HBoxContainer/LabelContainer/Label.text = "%1.2f" % (max_val * 0.01)
		$VBoxContainer/MarginContainer/HBoxContainer/LabelContainer/Label2.text = "%1.2f" % (max_val * 0.0075)
		$VBoxContainer/MarginContainer/HBoxContainer/LabelContainer/Label3.text = "%1.2f" % (max_val * 0.005)
		$VBoxContainer/MarginContainer/HBoxContainer/LabelContainer/Label4.text = "%1.2f" % (max_val * 0.0025)

		# generate price graph
	
		var line = Line2D.new()
		var points = PoolVector2Array()
		for i in range(values.size()):
			var normalized_coords = Vector2(float(i) / float(values.size() - 1), 1 - (float(values[i]) / float(max_val)))
			var world_coords = normalized_coords * line_control_node.rect_size
			points.append(world_coords)

		if values.size() > 1 && values[values.size() - 1] < values[values.size() - 2]:
			line.default_color = Color.red
		else:
			line.default_color = Color.green

		line.width = 1
		line.antialiased = true
	
		if line_control_node.get_child_count() > 0:
			line_control_node.get_child(0).queue_free()
		line.points = points
		line_control_node.add_child(line)
	
	var format_string = " %s - %3.2f€"
	var actual_string = format_string % [String(product_name), PriceManager.items[product_name].price() / 100.0] 
	$VBoxContainer/HBoxContainer/ProductName.text = actual_string
