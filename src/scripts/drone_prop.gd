extends Spatial


export var rot_speed = 20


func _process(delta: float) -> void:
	$Drone/propBL.rotation.y += delta * rot_speed
	$Drone/propBR.rotation.y -= delta * rot_speed
	$Drone/propFL.rotation.y -= delta * rot_speed
	$Drone/propFR.rotation.y += delta * rot_speed
