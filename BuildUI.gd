extends ColorRect

onready var line_container = $ScrollContainer/MarginContainer/VBoxContainer

func _on_BuildButton_pressed():
	visible = true

func _process(delta):
	if Input.is_action_just_pressed("build_button"):
		visible = !visible
	if Input.is_action_just_pressed("ui_cancel"):
		visible = false

func _ready():
	add_line("Smelter", 42000, preload("res://beingcreated/smelterbeingcreated.tscn"), preload("res://scenes/smelter.tscn"))
	add_line("Reactor", 42000, preload("res://beingcreated/reactorbeingcreated.tscn"), preload("res://reactor.tscn"))	
	add_line("Plasticery", 42000, preload("res://beingcreated/plasticerybeingcreated.tscn"), preload("res://scenes/Plasticery.tscn"))
	add_line("Watery", 42000, preload("res://beingcreated/waterybeingcreated.tscn"), preload("res://scenes/Watery.tscn"))
	add_line("Beamery", 42000, preload("res://beingcreated/beamerybeingcreated.tscn"), preload("res://Beamery.tscn"))
	add_line("Pipery", 42000, preload("res://beingcreated/piperybeingcreated.tscn"), preload("res://Pipery.tscn"))	
	add_line("Printery", 42000, preload("res://beingcreated/printerybeingcreated.tscn"), preload("res://Printery.tscn"))
	add_line("Sheetery", 42000, preload("res://beingcreated/sheeterybeingcreated.tscn"), preload("res://Sheetery.tscn"))
	add_line("Mixery", 42000, preload("res://beingcreated/mixerbeingcreated.tscn"), preload("res://scenes/mixer.tscn"))
	add_line("Panelery", 42000, preload("res://panelerybeingcreated.tscn"), preload("res://Panelery.tscn"))
	
func add_line(machine_name, price, inprogresstype, realtype):
	var x = preload("res://MachineBuyLine.tscn").instance()
	x.init(machine_name, price, inprogresstype, realtype)
	x.connect("buy_machine_button_clicked", self, "_on_MachineBuyLine_buy_machine_button_clicked" ,[machine_name, price, inprogresstype, realtype])
	line_container.add_child(x)

signal buy_machine(machine_name, price, inprogresstype, realtype)

func _on_MachineBuyLine_buy_machine_button_clicked(machine_name, price, inprogresstype, realtype):
	emit_signal("buy_machine", machine_name, price, inprogresstype, realtype)
	visible = false
