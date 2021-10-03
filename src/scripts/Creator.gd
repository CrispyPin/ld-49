extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var box = load('res://scenes/ValuedBox.tscn')
onready var consumer = get_node("/root/Game/ChildConsumer")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
var timer = 0
var timePerBox = 1
func _process(delta):
	timer+=delta
	if timer>timePerBox:
		timer=0
		var boxInstance = box.instance()
		consumer.add_child(boxInstance)
		boxInstance.global_transform.origin = global_transform.origin

