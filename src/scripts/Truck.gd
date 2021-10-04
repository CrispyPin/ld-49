extends VehicleBody

var enableEngine := false
var currentForce := 0
func _ready() -> void:
	#engine_force = 1*mass
	$Deleter.connect("box_consumed", self, "_on_Deleter_box_consumed")
	pass

func _process(delta):
	if enableEngine:
		currentForce += delta*mass*0.3
		engine_force = currentForce
	else:
		engine_force = 0

func _on_Deleter_box_consumed() -> void:
	print("DELETE SIGNAL RECIVED")
	enableEngine = true
