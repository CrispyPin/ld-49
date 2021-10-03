extends RigidBody


onready var player = get_node("/root/Game/Player")
var target := Vector3()
var attack := false

func _ready() -> void:
	pass

var playerSpeedFactor := 3

func _physics_process(delta: float) -> void:
	var target : Vector3 = player.global_transform.origin#+linear_velocity*playerSpeedFactor
	var dir : Vector3 = (target - global_transform.origin).normalized()
	add_central_force(5*dir)
	#	if attack:
	#		linear_velocity = (target - global_transform.origin).normalized() * 8
	#		if (translation - target).length() < 8:
	#			#attack = false
	#			pass


func _on_Area_body_entered(body: Spatial) -> void:
	if body.is_in_group("player"):# and !attack:
		target = body.translation
		attack = true
