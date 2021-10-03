extends RigidBody


onready var player = get_node("/root/Game/Player")
var target := Vector3()
var attack := false

func _ready() -> void:
	pass

var maxSpeed = 20
var forceFactor = 5
var playerSpeedFactor: float = 0.003*forceFactor



func _physics_process(delta: float) -> void:
	var distToPlayer = player.global_transform.origin.distance_to(global_transform.origin)
	var target: Vector3 = player.global_transform.origin+player.linear_velocity*playerSpeedFactor*distToPlayer
	var targetDir: Vector3 = (target - global_transform.origin).normalized()
	var error: Vector3 = linear_velocity-linear_velocity.project(targetDir)
	if error.length() > 3:
		error = error.normalized()*3

	var total: Vector3 = -error + targetDir

	add_central_force(forceFactor*total)
	if (linear_velocity.length()>maxSpeed):
		add_central_force(-linear_velocity.normalized()*10)
	#	if attack:
	#		linear_velocity = (target - global_transform.origin).normalized() * 8
	#		if (translation - target).length() < 8:
	#			#attack = false
	#			pass


func _on_Area_body_entered(body: Spatial) -> void:
	if body.is_in_group("player"):# and !attack:
		target = body.translation
		attack = true
