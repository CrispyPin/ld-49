extends VehicleBody

var enableEngine := false
var currentForce := 0

var since_box = -1

var boxCount = 0

func _ready() -> void:
	engine_force = 0
	$Deleter.connect("box_consumed", self, "_on_Deleter_box_consumed")

func _process(delta):
	if since_box != -1:
		since_box += delta
	if since_box > 1.0:
		if enableEngine == false:
			Global.addScore(Global.stopTimer(), boxCount)
			enableEngine = true

	if enableEngine:
		currentForce += delta*mass*0.3
		engine_force = currentForce
	else:
		engine_force = 0

	axis_lock_linear_x = not enableEngine		

func _on_Deleter_box_consumed() -> void:
	since_box = 0
	boxCount+=1
	if get_node_or_null("Arrow"):
		$Arrow.queue_free()
