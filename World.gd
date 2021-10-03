extends Spatial

onready var droidbody = $Droid

## Expansion
onready var expansion_area = $ExpansionArea
onready var gridmap = $GridMap

var template_top_right = Vector3(10, 3, 5)
var template_bottom_left = Vector3(1, -7, -7)
var template_expansion_area = Vector3(7, 0, 4)
onready var expansion_area_increment = gridmap.world_to_map(expansion_area.global_transform.origin) - template_expansion_area

func _on_ExpansionArea_body_entered(body):
	if body == droidbody:
		$GameplayUILayer/ExpansionDialog.visible = true

func _on_ExpansionArea_body_exited(body):
	if body == droidbody:
		$GameplayUILayer/ExpansionDialog.visible = false

func _on_BuyExpansionButton_pressed():
	var areapos = gridmap.world_to_map(expansion_area.global_transform.origin)
	var offset = areapos - template_expansion_area
	print("areapos",areapos)
	print("offset",offset)
	

	for tx in range(template_bottom_left.x, template_top_right.x):
		for ty in range(template_bottom_left.y, template_top_right.y):
			for tz in range(template_bottom_left.z, template_top_right.z):
				var nx = tx+offset.x
				var ny = ty+offset.y
				var nz = tz+offset.z
				var ox = nx-expansion_area_increment.x
				var oy = ny-expansion_area_increment.y
				var oz = nz-expansion_area_increment.z
				var item = gridmap.get_cell_item(ox,oy,oz)
				var orientation = gridmap.get_cell_item_orientation(ox,oy,oz)
				gridmap.set_cell_item(nx,ny,nz,item,orientation)
	var newea = areapos + expansion_area_increment
	expansion_area.global_transform.origin = gridmap.map_to_world(newea.x, newea.y, newea.z)
