extends Node

# the goods that can be sold and their base prices
export(Dictionary) var sale_goods

# the goods that can be bought and their base prices
export(Dictionary) var purchase_goods


class Item:
	var prices: PoolIntArray
	var trend: float
	var volatility: float
	var rng: RandomNumberGenerator
	var base_price: int
	var regime_change_chance: float
	var sellable: bool
	
	
	func _init(_base_price: int, _sellable: bool):
		self.base_price = _base_price
		prices = PoolIntArray()
		prices.append(base_price)
		rng = RandomNumberGenerator.new()
		rng.randomize()
		regime_change()
		regime_change_chance = 0.0
		sellable = _sellable
	
	# changes the trend and volatility of an item
	func regime_change():
		#determine trend
		var r = rng.randf()
		
		if r < 0.02:
			trend = 0.02
		elif r < 0.35:
			trend = 0.01
		elif r < 0.65:
			trend = 0.0
		elif r < 0.98:
			trend = -0.01
		else:
			trend = 0.02
		#determine volatilty
		r = rng.randf()
		if r < 0.04:
			volatility = 0.05
		elif r < 0.96:
			volatility = 0.02
		else:
			volatility = 0.01

	# gets the next price for an item
	func next_price():
		if prices.size() > 127:
			prices.remove(0)
		if rng.randf() < regime_change_chance:
			regime_change()
			regime_change_chance = 0.0
		regime_change_chance += 0.02
		
		var price_change: float = rng.randfn(trend, volatility) * base_price
		price_change += (base_price - price()) * 0.005
		prices.append(int(max(price() + price_change, 0.1 * base_price)))

	# gets the current price of an item
	func price() -> int:
		return prices[prices.size() - 1]
	

var time: float = 0.0
var items: Dictionary

func _process(delta):
	time += delta
	if time > 2.0:
		time -= 2.0
		for item in items:
			items[item].next_price()
	
func _enter_tree():
	for product in sale_goods:
		items[product] = Item.new(sale_goods[product], true)

	for product in purchase_goods:
		items[product] = Item.new(purchase_goods[product], false)
