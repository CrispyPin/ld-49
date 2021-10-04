extends Control


func _ready() -> void:
	if Global.enable_tutorial:
		visible = true

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("toggle_tutorial"):
		visible = !visible
