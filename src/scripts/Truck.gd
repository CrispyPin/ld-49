extends VehicleBody


func _ready() -> void:
	engine_force = 1*mass


func _on_Deleter_box_consumed() -> void:
	engine_force = 100*mass
