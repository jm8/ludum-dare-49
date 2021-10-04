extends Spatial

var good setget set_good

func init(mesh, shape):
	$mesh.set_mesh(mesh)
	$"Area/CollisionShape".shape = shape
	

func set_good(new):
	good = new
	for child in get_children():
		if child is MeshInstance:
			for i in range(child.get_surface_material_count()):
				child.get_surface_material(i).set_shader_param("good", new)
