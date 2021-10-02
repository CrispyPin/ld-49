extends Spatial


const tile = preload("res://scenes/Tile.tscn")

export var distance = 128
export var tile_size = 64

var player
var pos_z = 0


func _ready() -> void:
	player = get_node("/root/Game/Player")


func _process(_delta: float) -> void:
	if player.translation.z - distance < pos_z:
		add_tile()


func add_tile():
	var new = tile.instance()
	pos_z -= tile_size
	new.translation.z = pos_z
	add_child(new)
