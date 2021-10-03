extends Area


func _ready():
	monitoring = true

func _on_BoxConsumer_body_entered(body):
	print("AAAAAAAAAA")
	if body.is_in_group("box"):
		body.queue_free()
