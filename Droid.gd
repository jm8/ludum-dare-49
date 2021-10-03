extends Spatial

onready var physics = $RigidBody
onready var meshwithoutoffset = $MeshWithoutOffset
onready var cast = $MeshWithoutOffset/SmallBoy/DroidMesh/RayCast

var acceleration = 30
var steering = 30
var turn_speed = 5

var input_forward = 0
var input_turn = 0

func _ready():
	print(cast)
	cast.add_exception(physics)

func _physics_process(delta):
	meshwithoutoffset.transform.origin = physics.transform.origin
	physics.add_central_force(-meshwithoutoffset.global_transform.basis.z * input_forward)
	
func _process(delta):
	input_forward = 0
	input_forward += Input.get_action_strength("forward")
	input_forward -= Input.get_action_strength("backward")
	input_forward *= acceleration
	
	input_turn = 0
	input_turn += Input.get_action_strength("left")
	input_turn -= Input.get_action_strength("right")
	input_turn *= deg2rad(steering)

	var rotated = meshwithoutoffset.global_transform.basis.rotated(meshwithoutoffset.global_transform.basis.y, input_turn)
	meshwithoutoffset.global_transform.basis = meshwithoutoffset.global_transform.basis.slerp(rotated, turn_speed * delta)
	meshwithoutoffset.global_transform.basis = meshwithoutoffset.global_transform.basis.orthonormalized()
	
	var n = cast.get_collision_normal()
	var xform = align_with_y(meshwithoutoffset.global_transform, n.normalized())
	meshwithoutoffset.global_transform = meshwithoutoffset.global_transform.interpolate_with(xform, 10 * delta)

	
func align_with_y(xform, new_y):
	xform.basis.y = new_y
	xform.basis.x = -xform.basis. z.cross(new_y)
	xform.basis = xform.basis.orthonormalized()
	return xform


