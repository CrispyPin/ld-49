extends Spatial

const shelf_variants = [
	preload("res://scenes/shelves/Shelves-1.tscn"),
	preload("res://scenes/shelves/Shelves-2.tscn"),
	preload("res://scenes/shelves/Shelves-3.tscn"),
]

const item_variants = [
	preload("res://scenes/shelf-items/ShelfItem-1.tscn"),
	preload("res://scenes/shelf-items/ShelfItem-2.tscn"),
	preload("res://scenes/shelf-items/ShelfItem-3.tscn"),
	preload("res://scenes/shelf-items/ShelfItem-4.tscn"),
	preload("res://scenes/shelf-items/ShelfItem-5.tscn"),
	preload("res://scenes/shelf-items/ShelfItem-6.tscn"),
]

const container_variants = [
	preload("res://scenes/containers/Container-1.tscn"),
	preload("res://scenes/containers/Container-2.tscn"),
	preload("res://scenes/containers/Forklift.tscn"),
]

const shork_item = preload("res://scenes/shelf-items/ShelfItem-Shork.tscn")

const forklift = preload("res://scenes/containers/Forklift.tscn")

const enemy = preload("res://scenes/DodecaCopter.tscn")

const wall = preload("res://scenes/Wall.tscn")
const wall_door = preload("res://scenes/WallDoor.tscn")

const creator = preload("res://scenes/Creator.tscn")

var isTruck : bool = false
var isCreator : bool = false

export var disable_spawning = false
export var container_chance = 0.15
export var forklift_chance = 0.2
export var enemy_chance_per_distance = 0.003
var enemy_chance = 0
export var container_count = 8

export var wall_r: bool
export var wall_l: bool

func _ready() -> void:
	enemy_chance = 0.02#enemy_chance_per_distance * -get_parent().pos_z * 0.01
	if wall_r:
		var w
		if isTruck:
			w = wall_door.instance()
		else:
			w = wall.instance()
		w.translation.x = -36
		w.rotation_degrees.y = 180
		add_child(w)
	if wall_l:
		var w
		if isTruck:
			w = wall_door.instance()
		else:
			w = wall.instance()
		w.translation.x = 36
		add_child(w)

	if disable_spawning:
		return
	if isCreator:
		var pipe = creator.instance()
		pipe.translation.x = -8
		add_child(pipe)
		return
	if isTruck:
#		add_child(truck.instance())
		return


	var r = randf()
	if r < container_chance:
		add_containers()
	elif r < forklift_chance + container_chance:
		add_forklifts()
	else:
		add_shelves()

func add_forklifts():
	for i in range(4):
		var posx = rand_range(-24, 24)
		var posz = rand_range(-24, 25)

		var roty = rand_range(-3, 3.5)
		var f = forklift.instance()
		f.translation = Vector3(posx, 1, posz)
		f.rotation.y = roty
		add_child(f)

	for i in range(50):
		add_item(Vector3(rand_range(-16, 16), rand_range(2,15), rand_range(-24, 24)))



func add_containers() -> void:
	for i in range(container_count):
		var posx = rand_range(-24, 24)
		var posz = rand_range(-24, 25)

		var roty = rand_range(-3, 3.5)
		var type = randi() % len(container_variants)
		var container_node = container_variants[type].instance()
		container_node.translation.x = posx
		container_node.translation.z = posz
		container_node.translation.y = i*12+4
		container_node.rotation.y = roty
		add_child(container_node)


func add_shelves() -> void:
	var numShelves : int= 5
	var spread := 6
	for z in [0, 32]:
		for x in range(-numShelves,numShelves+1):
			if rand_range(0,1)>0.7:
				add_shelf(x*spread,z)


func add_shelf(x: float, z: float) -> void:
	var type = randi() % len(shelf_variants)
	var shelf_node = shelf_variants[type].instance()
	shelf_node.translation.x = x
	shelf_node.translation.z = z
	add_child(shelf_node)
	fill_shelf(shelf_node)


func fill_shelf(shelf) -> void:
	for s in shelf.get_node("SpawnPoints").get_children():
		if randf() < 0.4:
			continue
		var pos = s.translation + shelf.translation
		if randf() < enemy_chance and s.translation.y < 10:
			var e = enemy.instance()
			e.translation = pos
			add_child(e)
		else:
			add_item(pos)


func add_item(pos: Vector3):
	var type = randi() % len(item_variants)
	var item = item_variants[type].instance()
	if randf() < 0.01:
		item = shork_item.instance()
	item.translation = pos
	item.rotation_degrees.y = randf()*360
	add_child(item)

