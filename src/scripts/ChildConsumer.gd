extends Spatial

onready var player = get_node("/root/Game/Player")

func _ready():
    pass

func _process(_delta: float) -> void:
	pass
	for child in self.get_children():
		if child.translation.z>player.translation.z+Global.playerDeleteMargin:
			child.queue_free()

