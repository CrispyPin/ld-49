extends ARVROrigin


onready var player = get_node("../Player")

func _ready() -> void:
	var arvr_interface = ARVRServer.find_interface("OpenVR")
	if arvr_interface and arvr_interface.initialize():
		get_viewport().arvr = true
		OS.vsync_enabled = false

func _process(delta: float) -> void:
	translation = player.translation
