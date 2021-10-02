extends VehicleBody


func _ready():
    engine_force = .01
    steering = 0

var timer = 0
func _process(delta):
	timer+=delta
	if timer>0.5:
		timer = 0
		engine_force = rand_range(-200,200)
		steering = (3.1415/180.0)*rand_range(-45,45)
