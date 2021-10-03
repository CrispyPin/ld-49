extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
var gravity = 9.8
var yAcceleration = gravity
var throttleSpeed = 0.2*60

var ySpeedDamping = 0.05
var directYcontrolFactor = 5

var maxLateralSpeed = 50

func _ready():


	pass # Replace with function body.

var tiltSpeed = 2

var xdir = 0; # left right
var zdir = 0; # forward backward

var ydir = 0; # up down

func _integrate_forces(state):
	#state.set_angular_velocity(Vector3(0,yAcceleration,0))
	var xdirReduced = xdir-(linear_velocity.x/maxLateralSpeed)
	var zdirReduced = zdir-(linear_velocity.z/maxLateralSpeed)
	state.transform = transform.interpolate_with(transform.looking_at(translation + Vector3(0,zdirReduced,-1),Vector3(xdirReduced,1,zdirReduced)),state.step*tiltSpeed)
	pass

func _physics_process(_delta):
	#look_at(translation + Vector3(0,zdir,-1),Vector3(xdir,1,zdir))
	var decreaseAccelerationFactor = translation.y*0.7
	var totalYAcceleration = (yAcceleration-decreaseAccelerationFactor)
	totalYAcceleration -= pow(linear_velocity.y,3)*ySpeedDamping
	totalYAcceleration += ydir*directYcontrolFactor

	var up = transform.basis.y

	var xAcceleration = up.x*totalYAcceleration;
	var zAcceleration = up.z*totalYAcceleration;

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
	#yAcceleration = min(yAcceleration, gravity*4.05)



