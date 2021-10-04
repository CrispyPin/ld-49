extends VehicleBody

var enableEngine := false
var currentForce := 0

var since_box = -1

var boxCount = 0

func _ready() -> void:
	$Deleter.connect("box_consumed", self, "_on_Deleter_box_consumed")

func _process(delta):
	if since_box != -1:
		since_box += delta
	if since_box > 1.0:
		if !enableEngine:
			print("---------------")
			print(Global.stopTimer())
			print(boxCount)
		enableEngine = true

	if enableEngine:
		currentForce += delta*mass*0.3
		engine_force = currentForce
	else:
		engine_force = 0

func _on_Deleter_box_consumed() -> void:
	since_box = 0
<<<<<<< HEAD
	if get_node_or_null("Arrow"):
=======
	boxCount+=1
	if $Arrow:
>>>>>>> bd833cd8a0388430ef1294c8140fa8128d82a2af
		$Arrow.queue_free()
