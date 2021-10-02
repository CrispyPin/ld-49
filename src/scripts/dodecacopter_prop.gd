extends Spatial


export var rot_speed = 64

var props: Array

func _ready() -> void:
	for arm in $core.get_children():
		props.append(arm.get_child(0))


func _process(delta: float) -> void:
	for p in props:
		p.rotation.y += delta * rot_speed
