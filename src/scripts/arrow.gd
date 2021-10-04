extends Spatial

export var rspeed = -180
export var yspeed = 5

var t = 0

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	t += delta
	rotation_degrees.y += delta * rspeed
	$arrow.translation.y = sin(t * yspeed)
