extends Camera


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var player = get_node("/root/Game/Player")

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translation = player.translation + Vector3(0,2,5)
	rotation_degrees = Vector3(-30,0,0)
	pass

