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
]

const container_variants = [
	preload("res://scenes/containers/Container-1.tscn"),
	preload("res://scenes/containers/Container-2.tscn"),
	preload("res://scenes/containers/Forklift.tscn"),
]

const forklift = preload("res://scenes/containers/Forklift.tscn")

const enemy = preload("res://scenes/DodecaCopter.tscn")

export var container_chance = 0.15
export var forklift_chance = 0.2
export var container_count = 8

func _ready() -> void:
	randomize()
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

	for i in range(100):
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
	for x in [-24, -12, 12, 24]:
		for z in [0, 32]:
			var type = randi() % len(shelf_variants)
			var shelf_node = shelf_variants[type].instance()
			shelf_node.translation.x = x
			shelf_node.translation.z = z
			add_child(shelf_node)
			fill_shelf(shelf_node)


func fill_shelf(shelf) -> void:
	for s in shelf.get_node("SpawnPoints").get_children():
		add_item(s.translation + shelf.translation)


func add_item(pos: Vector3):
	var type = randi() % len(item_variants)
	var item = item_variants[type].instance()
	item.translation = pos
	add_child(item)

