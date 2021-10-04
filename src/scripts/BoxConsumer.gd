extends Area

signal box_consumed

func _ready():
	monitoring = true

func _on_BoxConsumer_body_entered(body):
	if body.is_in_group("box"):
		emit_signal("box_consumed")
		body.queue_free()


func _on_Area_body_exited(body):
	if body.is_in_group("player"):
		Global.startTimer()
