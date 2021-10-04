extends Control

const MachineLabel = preload("res://MachineLabel.tscn")

func _ready():
	SignalBus.connect("machine_created", self, "_on_SignalBus_machine_created")

func _on_SignalBus_machine_created(machine):
	var label = MachineLabel.instance()
	label.init(machine)
	add_child(label)
	
