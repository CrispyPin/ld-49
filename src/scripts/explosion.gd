extends Spatial

export var radius = 10
export var power = 10

var time = 0

func _ready() -> void:
	$Area.gravity = -power
	$Area/CollisionShape.shape.radius = radius
	$Particles.emitting = true

func _process(delta: float) -> void:
	time += delta
	if time > 0.5:
		if get_node_or_null("Area"):
			$Area.queue_free()
	if time > 10:
		queue_free()
