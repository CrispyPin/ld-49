extends VehicleBody

var made_baby := false
var timer = 0

func _ready():
    engine_force = .01
    steering = 0

func _process(delta):
	timer+=delta
	if timer>0.5:
		timer = 0
		engine_force = rand_range(-200,200)
		steering = (3.1415/180.0)*rand_range(-45,45)


func _on_TopArea_body_entered(body: Node) -> void:
	if body.is_in_group("forklift"):
		reproduce()
		body.made_baby = true


# don't ask
func reproduce():
	if made_baby:
		return
	made_baby = true

	var baby = load("res://scenes/ForkliftBaby.tscn").instance()
	baby.translation = translation + Vector3(0, 0, -8)
	get_parent().add_child(baby)


