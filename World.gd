
extends Spatial

onready var droidbody = $Droid

## Generation
onready var gridmap = $GridMap

var floors = []
var walls = []
var corner_walls = []
var angled_edges = []
var corners = []

var size = 2

func _ready():
	get_block_names()
	generate(size)
	
func get_block_names():
	for id in gridmap.mesh_library.get_item_list():
		var name = gridmap.mesh_library.get_item_name(id)
		if name.begins_with("Floor"):
			if name == "Floor0":
				floors.push_front(id)
			else:
				floors.push_back(id)
		elif name.begins_with("Wall"):
			if name == "Wall0":
				walls.push_front(id)
			else:
				walls.push_back(id)
		elif name.begins_with("CornerWall"):
			corner_walls.push_back(id)
		elif name.begins_with("Corner"):
			corners.push_back(id)
		elif name.begins_with("AngledEdge"):
			angled_edges.push_back(id)
			
		

func generate(r):
	fill_floor(r)
	fill_edges(r)
	fill_corners(r)
	remove_inner(r)

func irange(low,high):
	return range(low, high+1)

func cmpinrange(x,r):
	if x < -r:
		return -1
	elif x > r:
		return 1
	else:
		return 0

func orientation(x,z,r):	
	var d = {
		#edges
		Vector2(-1,0): 16,
		Vector2(1,0): 22,
		Vector2(0,1): 10,
		Vector2(0,-1): 0,
		
		#corners
		Vector2(-1,-1): 0,
		Vector2(1,-1): 22,
		Vector2(-1,1): 16,
		Vector2(1,1): 10
		
	}
	return d.get(Vector2(cmpinrange(x,r),cmpinrange(z,r)), 0)

func get_random_item(y, a, b):
	var array
	if y == 0:
		array = a
	else:
		array = b
	if randi()%2:
		return array[randi() % len(array)]
	else:
		return array[0]

func fill_edges(r):
	for y in [0, 1]:
		for x in [-r-1, r+1]:
			for z in irange(-r, r):
				gridmap.set_cell_item(x,y,z,get_random_item(y,angled_edges,walls),orientation(x,z,r))
		for z in [-r-1, r+1]:
			for x in irange(-r, r):
				gridmap.set_cell_item(x,y,z,get_random_item(y,angled_edges,walls),orientation(x,z,r))

func fill_corners(r):
	for y in [0, 1]:
		for x in [-r-1, r+1]:
			for z in [-r-1, r+1]:
				gridmap.set_cell_item(x,y,z,get_random_item(y,corners,corner_walls),orientation(x,z,r))

func fill_floor(r):
	for x in irange(-r,r):
		for z in irange(-r,r):
			gridmap.set_cell_item(x,0,z,floors[0])

func remove_inner(r):
	for x in irange(-r, r):
		for z in irange(-r, r):
			gridmap.set_cell_item(x,1,z,-1)

func _on_ExpandButton_pressed():
	size += 1
	generate(size)
