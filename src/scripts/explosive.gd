extends RigidBody

const explosion = preload("res://scenes/Explosion.tscn")

export var max_dist = 8
export var power = 10
export var explosion_scale = 1
export var wait_time = 5

var start_pos: Vector3
var settled := false
var time: float

onready var player:Spatial = get_node("/root/Game/Player")

func _ready() -> void:
	time = 0


func _process(delta: float) -> void:
	time += delta
	if !settled and time > wait_time:
		settled = true
		start_pos = translation

	if settled:
		var moved = translation - start_pos
		var pdist = (global_transform.origin - player.translation).length()
		if moved.length() > max_dist and pdist > 40:
			explode()

func explode() -> void:
	var e = explosion.instance()
	e.translation = translation
	e.power = power
	e.scale *= explosion_scale
	get_parent().add_child(e)
	queue_free()
