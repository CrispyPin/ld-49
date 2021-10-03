extends RigidBody


const package_models = [
	preload("res://models/packages/package-1.glb"),
	preload("res://models/packages/package-2.glb"),
	preload("res://models/packages/package-3.glb"),
]

var type: int

func _ready() -> void:
	$placeholder.queue_free()
	type = randi() % len(package_models)
	var model = package_models[type].instance()
	add_child(model)
