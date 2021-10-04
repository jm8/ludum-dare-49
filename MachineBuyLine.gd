extends HBoxContainer

var price

func init(machine_name, price, inprogresstype, realtype):
	self.price = price
	$Name.text = machine_name
	$Price.text = "€%.2f" % [price / 100]

signal buy_machine_button_clicked

func _process(delta):
	$BuildButton.disabled = Globals.money < price

func _on_BuildButton_pressed():
	if Globals.money >= price:
		Globals.money -= price
		emit_signal("buy_machine_button_clicked")
