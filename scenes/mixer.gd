extends Spatial

onready var copper_texture = preload("res://resources/models/items/copper.tres")
onready var aluminum_texture = preload("res://resources/models/items/aluminum.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(_delta):
	if $Machine.is_active():
		$"mixer-animation/AnimationPlayer".play("spin")
		$light/OmniLight.light_color = Color.green
		$light.get_active_material(0).albedo_color = Color.green
	else:
		$"mixer-animation/AnimationPlayer".stop(false)
		$light/OmniLight.light_color = Color.red
		$light.get_active_material(0).albedo_color = Color.red
	if $Machine.current_recipe == 0:
		$paintcolor.material_override = copper_texture
	if $Machine.current_recipe == 1:
		$paintcolor.material_override = aluminum_texture
