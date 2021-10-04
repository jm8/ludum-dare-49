extends Spatial

var good setget set_good

func init(mesh, shape):
	$mesh.set_mesh(mesh)
	$"Area/CollisionShape".shape = shape
	

func set_good(new):
	good = new
	for child in get_children():
		if child is MeshInstance:
			child.get_surface_material(0).set_shader_param("good", new)
