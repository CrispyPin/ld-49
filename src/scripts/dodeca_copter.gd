extends RigidBody


var target := Vector3()
var attack := false

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if attack:
		linear_velocity = (target - global_transform.origin).normalized() * 1
		if (translation - target).length() < 8:
			linear_velocity = Vector3()
			attack = false


func _on_Area_body_entered(body: Spatial) -> void:
	if body.is_in_group("player") and !attack:
		target = body.translation
		attack = true
