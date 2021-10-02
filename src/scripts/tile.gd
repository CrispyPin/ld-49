extends Spatial

const shelf_variants = [
	preload("res://scenes/shelves/Shelves-1.tscn"),
	preload("res://scenes/shelves/Shelves-2.tscn"),
	preload("res://scenes/shelves/Shelves-3.tscn"),
]

const item_variants = [
	preload("res://scenes/shelf-items/ShelfItem-1.tscn"),
	preload("res://scenes/shelf-items/ShelfItem-2.tscn"),
]

const container_variants = [
	preload("res://scenes/containers/Container-1.tscn"),
	preload("res://scenes/containers/Container-2.tscn"),
]


func _ready() -> void:
	randomize()
	if randf() < 0.2:
		add_containers()
	else:
		add_shelves()


func add_containers() -> void:
	for i in range(8):
		var posx = rand_range(-12, 12)
		var posz = rand_range(-12, 12)
		var roty = rand_range(-3, 3.5)
		var type = randi() % len(container_variants)
		var container_node = container_variants[type].instance()
		container_node.translation.x = posx
		container_node.translation.z = posz
		container_node.translation.y = 16
		container_node.rotation.y = roty
		add_child(container_node)


func add_shelves() -> void:
	for x in [-28, -12, 12, 28]:
		for z in [0, 32]:
			var type = randi() % len(shelf_variants)
			var shelf_node = shelf_variants[type].instance()
			shelf_node.translation.x = x
			shelf_node.translation.z = z
			add_child(shelf_node)
			fill_shelf(shelf_node)


func fill_shelf(shelf) -> void:
	for z in range(4):
		var posz = -z*8 - 4
		for y in range(4):
			var posy = y*4 + 4
			var type = randi() % len(item_variants)
			var item_node = item_variants[type].instance()
			item_node.translation.z = posz
			item_node.translation.y = posy
			shelf.add_child(item_node)
