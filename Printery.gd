extends Spatial


func _process(_delta):
	if $Machine.is_active():
		$cnc/AnimationPlayer.play("Action")
	else:
		$cnc/AnimationPlayer.stop()
