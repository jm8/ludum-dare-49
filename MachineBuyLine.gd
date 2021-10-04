extends HBoxContainer

func init(machine_name, price, inprogresstype, realtype):
	$Name.text = machine_name
	$Price.text = "€%.2f" % [price]

signal buy_machine_button_clicked

func _on_BuildButton_pressed():
	emit_signal("buy_machine_button_clicked")
