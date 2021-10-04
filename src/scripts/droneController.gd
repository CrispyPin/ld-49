extends RigidBody


var gravity = 9.8
var yAcceleration = gravity
var throttleSpeed = 0.2*60

var ySpeedDamping = 0.05
var directYcontrolFactor = 5

var maxLateralSpeed = 50*2

func _ready():


	pass # Replace with function body.

var tiltSpeed = 2*2

var xdir = 0; # left right
var zdir = 0; # forward backward

var ydir = 0; # up down

var flipped = false

var yMotorDir = 1

func _integrate_forces(state):
	#state.set_angular_velocity(Vector3(0,yAcceleration,0))
	var heightSlowDownFactor = max(0,translation.y-4)*3
	var adjustedMaxSpeed = max(maxLateralSpeed-heightSlowDownFactor,maxLateralSpeed*0.3)
	var xdirReduced = clamp(yMotorDir*xdir-(linear_velocity.x/adjustedMaxSpeed)*yMotorDir, -1, 1)
	var zdirReduced = clamp(yMotorDir*zdir-(linear_velocity.z/adjustedMaxSpeed)*yMotorDir, -1, 1)


	if flipped:
		state.transform = transform.interpolate_with(transform.looking_at(translation + Vector3(0,-zdirReduced,-1),Vector3(xdirReduced,-1,zdirReduced)),state.step*tiltSpeed)
	else:
		state.transform = transform.interpolate_with(transform.looking_at(translation + Vector3(0,zdirReduced,-1),Vector3(xdirReduced,1,zdirReduced)),state.step*tiltSpeed)

func _physics_process(_delta):
	var up = transform.basis.y
	var yDotProduct	= up.dot(Vector3(0,1,0))
	if yDotProduct > 0:
		yMotorDir = 1
	else:
		yMotorDir = -1


	#look_at(translation + Vector3(0,zdir,-1),Vector3(xdir,1,zdir))
	var decreaseAccelerationFactor = translation.y*0.7
	var totalYAcceleration = (yAcceleration-decreaseAccelerationFactor)
	totalYAcceleration -= pow(linear_velocity.y,3)*ySpeedDamping
	totalYAcceleration += ydir*directYcontrolFactor

	if abs(yDotProduct)<0.7:
		totalYAcceleration = 0


	var xAcceleration = up.x*totalYAcceleration*yMotorDir;
	var zAcceleration = up.z*totalYAcceleration*yMotorDir;

	add_central_force(mass*Vector3(xAcceleration,totalYAcceleration,zAcceleration))
	#rotation_degrees.x = yAcceleration;
	#rotate_y(delta*yAcceleration)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	var dir = Vector2( Input.get_action_strength("left")- Input.get_action_strength("right"), Input.get_action_strength("forward")- Input.get_action_strength("backward"))
	dir=-dir.clamped(1)
	xdir = dir.x
	zdir = dir.y
	#zdir = 0
	#if Input.is_action_pressed("forward"):
	#	zdir = -1.0
	#elif Input.is_action_pressed("backward"):
	#	zdir = 1.0

	#xdir = 0
	#if Input.is_action_pressed("left"):
	#	xdir = -1.0
	#elif Input.is_action_pressed("right"):
	#	xdir = 1.0

	ydir = Input.get_action_strength("increase_throttle")-Input.get_action_strength("decrease_throttle")
	#if Input.is_action_pressed("decrease_throttle"):
	#	ydir = -1.0;
	#if Input.is_action_pressed("increase_throttle"):
	#	ydir = 1.0


	yAcceleration+=ydir*throttleSpeed*delta

	yAcceleration = max(yAcceleration, gravity*1.05)
	$drone.rot_speed = (yAcceleration/gravity)*15

	if Input.is_action_just_pressed("flip"):
		flipped = !flipped
	#yAcceleration = min(yAcceleration, gravity*4.05)



