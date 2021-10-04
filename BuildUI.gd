extends ColorRect

onready var line_container = $ScrollContainer/MarginContainer/VBoxContainer

func _on_BuildButton_pressed():
	visible = true

func _process(delta):
	if Input.is_action_just_pressed("close_price_menu"):
		visible = false

func _ready():
	add_line("Smelter", 12, preload("res://beingcreated/smelterbeingcreated.tscn"), preload("res://scenes/smelter.tscn"))
	add_line("Reactor", 48, preload("res://beingcreated/reactorbeingcreated.tscn"), preload("res://reactor.tscn"))	
	
func add_line(machine_name, price, inprogresstype, realtype):
	var x = preload("res://MachineBuyLine.tscn").instance()
	x.init(machine_name, price, inprogresstype, realtype)
	x.connect("buy_machine_button_clicked", self, "_on_MachineBuyLine_buy_machine_button_clicked" ,[machine_name, price, inprogresstype, realtype])
	line_container.add_child(x)

signal buy_machine(machine_name, price, inprogresstype, realtype)

func _on_MachineBuyLine_buy_machine_button_clicked(machine_name, price, inprogresstype, realtype):
	emit_signal("buy_machine", machine_name, price, inprogresstype, realtype)
	visible = false
