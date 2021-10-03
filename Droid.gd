extends KinematicBody

onready var cast = $RayCast
onready var mesh = $NormalBoy

var gravity = Vector3(0, -40, 0)
var speed = 1.7
var velocity = Vector3(0,0,0)
var rotationalspeed = deg2rad(180)

func _physics_process(delta):
	velocity.x *= pow(.0001, delta)
	velocity.z *= pow(.0001, delta)
	velocity += gravity * delta
	
	velocity += -transform.basis.z * speed * Input.get_action_strength("forward")
	velocity -= -transform.basis.z * speed * Input.get_action_strength("backward")

	var rotate_strength = Input.get_action_strength("left") - Input.get_action_strength("right")
	rotate_y(rotationalspeed * rotate_strength * delta)
	
	var tilt = rotate_strength * velocity.length() / 25
	mesh.rotation.z = lerp(mesh.rotation.z, tilt, 10*delta)

	velocity = move_and_slide(velocity)
	
	var normal = cast.get_collision_normal()
	var xform = align_with_y(mesh.global_transform, normal)
	mesh.global_transform = mesh.global_transform.interpolate_with(xform, 0.05)

func align_with_y(xform, new_y):
	xform.basis.y = new_y
	xform.basis.x = -xform.basis.z.cross(new_y)
	xform.basis = xform.basis.orthonormalized()
	return xform
