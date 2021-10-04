extends KinematicBody
class_name Droid

onready var cast = $RayCast
onready var mesh = $NormalBoy

## Movement

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
	
	velocity = move_and_slide(velocity)
	
	#var normal = cast.get_collision_normal()
	#var xform = align_with_y(mesh.global_transform, normal)
	#mesh.global_transform = mesh.global_transform.interpolate_with(xform, 0.05)
	
	var tilt = rotate_strength * velocity.length() / 25
	mesh.rotation.z = lerp(mesh.rotation.z, tilt, 10*delta)

func align_with_y(xform, new_y):
	xform.basis.y = new_y
	xform.basis.x = -xform.basis.z.cross(new_y)
	xform.basis = xform.basis.orthonormalized()
	return xform

## Items

signal can_pick_up(item)
signal cannot_pick_up(item)
signal too_full_to_pick_up(item)
var item_to_pickup
var held_items = []
var max_held_items = 3

func _on_CollectionArea_area_entered(area):
	if area is GameItem:
		if len(held_items) >= max_held_items:
			too_full_to_pick_up(area)
		else:
			can_pick_up(area)

func _on_CollectionArea_area_exited(area):
	if item_to_pickup == area:
		cannot_pick_up(area)

func _process(_delta):
	if Input.is_action_just_pressed("pickup"):
		if item_to_pickup:
			if len(held_items) < max_held_items:
				item_to_pickup.attach_to(self)
				held_items.push_back(item_to_pickup)
				cannot_pick_up(item_to_pickup)
		elif held_items.size() >0:
			can_pick_up(held_items[len(held_items)-1])
			held_items[len(held_items) -1].drop()
			held_items.pop_back()
			
		
func can_pick_up(item):
	emit_signal("can_pick_up", item)
	item_to_pickup = item
	
func too_full_to_pick_up(item):
	emit_signal("too_full_to_pick_up", item)
	item_to_pickup = item
	
func cannot_pick_up(item):
	emit_signal("cannot_pick_up", item)
	item_to_pickup = null
