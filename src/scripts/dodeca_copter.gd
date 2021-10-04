extends RigidBody

const explosion = preload("res://scenes/Explosion.tscn")

onready var player = get_node("/root/Game/Player")

var maxSpeed = 20
var forceFactor = 5
var playerSpeedFactor: float = 0.003*forceFactor
var t = -1
export var lifetime = 5

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

	if distToPlayer < 20 and t == -1:
		t = 0
	if t != -1:
		t += delta
	if t > lifetime:
		explode()

func explode():
	var e = explosion.instance()
	e.translation = translation
	e.power = 10
	get_parent().add_child(e)
	queue_free()
