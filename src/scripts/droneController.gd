extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
var gravity = 9.8
var yAcceleration = gravity
var throttleSpeed = 0.2
func _ready():


	pass # Replace with function body.


var tiltSpeed = 2

var xdir = 0; # left right
var zdir = 0; # forward backward

func _integrate_forces(state):
	#state.set_angular_velocity(Vector3(0,yAcceleration,0))
	state.transform = transform.interpolate_with(transform.looking_at(translation + Vector3(0,zdir,-1),Vector3(xdir,1,zdir)),state.step*tiltSpeed)
	pass

func _physics_process(_delta):
	#look_at(translation + Vector3(0,zdir,-1),Vector3(xdir,1,zdir))
	var decreaseAccelerationFactor = translation.y*0.7
	var totalYAcceleration = (yAcceleration-decreaseAccelerationFactor)

	var up = transform.basis.y

	var xAcceleration = up.x*totalYAcceleration;
	var zAcceleration = up.z*totalYAcceleration;

	add_central_force(mass*Vector3(xAcceleration,totalYAcceleration,zAcceleration))
	#rotation_degrees.x = yAcceleration;
	#rotate_y(delta*yAcceleration)

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
		yAcceleration-=throttleSpeed
	if Input.is_action_pressed("increase_throttle"):
		yAcceleration+=throttleSpeed

	yAcceleration = max(yAcceleration, gravity*1.05)
	#yAcceleration = min(yAcceleration, gravity*4.05)



