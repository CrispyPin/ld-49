tool
extends Sprite3D


export var text: String setget set_text

func _process(delta: float) -> void:
	$Viewport.size = $Viewport/Label.rect_size


func set_text(new: String):
	text = new
	$Viewport/Label.text = text
