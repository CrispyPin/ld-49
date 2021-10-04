extends VehicleBody


func _ready() -> void:
	#engine_force = 1*mass
	$Deleter.connect("box_consumed", self, "_on_Deleter_box_consumed")
	pass


func _on_Deleter_box_consumed() -> void:
	print("DELETE SIGNAL RECIVED")
	engine_force = 1*mass
