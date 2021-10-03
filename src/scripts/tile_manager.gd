extends Spatial


const tile = preload("res://scenes/Tile.tscn")

export var wall_r = false
export var wall_l = false

export var distance = 512
export var tile_size = 64
export var back_distance = 64


var player
var pos_z = 0

var tiles
var numTiles = 0

func _ready() -> void:
	randomize()
	player = get_node("/root/Game/Player")
	tiles = []


func _process(_delta: float) -> void:
	if player.translation.z - distance < pos_z:
		add_tile()
	if numTiles>0:
		var firstTile = tiles[0] as Spatial
		#print("SEVERAL TILES")
		if firstTile:
			#print("NOT NIL")
			if firstTile.translation.z>player.translation.z+back_distance: # player goes towards -z
				#print("DELETING A TILE")
				firstTile.queue_free()
				numTiles-=1
				tiles.pop_front()






func add_tile():
	var new = tile.instance()
	tiles.append(new as Spatial)
	numTiles+=1
	pos_z -= tile_size
	new.translation.z = pos_z
	new.wall_r = wall_r
	new.wall_l = wall_l
	add_child(new)
