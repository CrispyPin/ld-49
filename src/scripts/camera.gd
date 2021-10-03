extends Spatial

var distance = 6

onready var player = get_node("/root/Game/Player")


func _ready() -> void:
	$Camera/Fogbox.visible = true


func _process(delta: float) -> void:
	translation = player.translation# + Vector3(0,2,5)
	rotation_degrees = Vector3(-30,0,0)
	zoom()


func zoom():
	$RayCast.cast_to = Vector3(0, 0, distance)
	$RayCast.force_raycast_update()
	var ray_len = ($RayCast.get_collision_point() - global_transform.origin).length()
	$Camera.translation = Vector3(0, 0, min(distance, max(ray_len, 1)))
