extends Spatial

const shelf_variants = [preload("res://models/shelves/shelves-1.glb"),
					preload("res://models/shelves/shelves-2.glb"),
					preload("res://models/shelves/shelves-3.glb")]

const item_variants = [preload("res://scenes/shelf-items/ShelfItem-1.tscn")]


func _ready() -> void:
	add_shelves()


func add_shelves() -> void:
	for x in [-28, -12, 12, 28]:
		for z in [0, 32]:
			var type = randi() % len(shelf_variants)
			var shelf_node = shelf_variants[type].instance()
			shelf_node.translation.x = x
			shelf_node.translation.z = z
			add_child(shelf_node)
			fill_shelf(shelf_node)

func fill_shelf(shelf):
	for z in range(4):
		var posz = -z*8 - 4
		for y in range(4):
			var posy = y*4 + 4
			var type = randi() % len(item_variants)
			var item_node = item_variants[type].instance()
			item_node.translation.z = posz
			item_node.translation.y = posy
			shelf.add_child(item_node)
