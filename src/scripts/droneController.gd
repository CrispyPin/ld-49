extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.

var yForce = 9.8
var throttleSpeed = 0.5

var xdir = 0; # left right 
var zdir = 0; # forward backward

func _integrate_forces(state):
	state.set_angular_velocity(Vector3(0,yForce,0))

func _physics_process(delta):
	var decreaseForceFactor = translation.y*0.8
	var totalForce = 60*(yForce-decreaseForceFactor)
	add_central_force(delta*Vector3(xdir*100,totalForce,zdir*100))
	#rotation_degrees.x = yForce;
	#rotate_y(delta*yForce)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	zdir = 0
	if Input.is_action_pressed("forward"):
		zdir = -1.0
	elif Input.is_action_pressed("backward"):
		zdir = 1.0
	
	xdir = 0
	if Input.is_action_pressed("left"):
		xdir = -1.0	
	elif Input.is_action_pressed("right"):
		xdir = 1.0

	if Input.is_action_pressed("decrease_throttle"):
		yForce-=throttleSpeed;
	if Input.is_action_pressed("increase_throttle"):
		yForce+=throttleSpeed;
