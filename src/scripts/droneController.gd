extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.

var yForce = 9.8
var throttleSpeed = 1
func _integrate_forces(state):
	state.set_angular_velocity(Vector3(0,yForce,0))

func _physics_process(delta):
	var decreaseForceFactor = translation.y*0.8
	add_central_force(Vector3(0,yForce-decreaseForceFactor,0))
	#rotation_degrees.x = yForce;
	#rotate_y(delta*yForce)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("decrease_throttle"):
		yForce-=throttleSpeed;
	if Input.is_action_pressed("increase_throttle"):
		yForce+=throttleSpeed;
