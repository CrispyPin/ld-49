extends Node
var initTiles = 40
var initTilesUntilTruck : int= initTiles
var initTilesUntilCreator : int= initTiles
var tilesUntilTruck : int = int(initTilesUntilTruck*0.8)
var tilesUntilCreator := 0
var tileMutex := Mutex.new()

var playerDeleteMargin : float= 8

var enable_tutorial := false

var scoreTimer = 0.0
var enableScoreTimer = false

var scores = []

func addScore(time: float, boxCount: int):
	scores.append([time, boxCount])

func startTimer():
	scoreTimer = 0.0
	enableScoreTimer = true

func stopTimer():
	var tmp = scoreTimer
	enableScoreTimer = false
	scoreTimer = 0.0
	return tmp

func _process(delta):
	if enableScoreTimer:
		scoreTimer+=delta


const PAUSE_IN_MENU  = true
const CAPTURE_CURSOR = false

const DEBUG_SETTINGS = false
const SETTINGS_PATH = "user://settings.json"
const SETTINGS_DEF = {}
#{
#    "example_toggle": {
#        "name": "Toggle (main menu)",
#        "flags": ["main_menu_only"],
#        "tooltip": "tooltip here",
#        "type": "toggle",
#        "default": false
#    },
#    "example_toggle2": {
#        "name": "Toggle",
#        "flags": [],
#        "type": "toggle",
#        "default": false
#    },
#    "example_toggle5": {
#        "name": "Toggle (main menu)",
#        "flags": ["main_menu_only"],
#        "type": "toggle",
#        "default": false
#    },
#    "example_number": {
#        "name": "Number setting",
#        "flags": [],
#        "type": "number",
#        "default": 420,
#        "min": 1,
#        "max": 10000,
#        "step": 1#optional
#    },
#    "example_choice": {
#        "name": "Dropdown: ",
#        "flags": [],
#        "type": "choice",
#        "default": 1,
#        "options": ["Option A", "Option B", "Option C"]
#    }
#}

var game_loaded = false
var settings_loaded = false
var paused = false
var settings = {}


func _ready() -> void:
    _init_settings()
    load_settings()
    settings_loaded = true
    get_node("/root/Default").queue_free()


func set_setting(key, val):
    settings[key] = val
    if DEBUG_SETTINGS:
        print("Settings changed. ", key, ": ", val)
    save_settings()


func _init_settings():
    for key in SETTINGS_DEF:
        settings[key] = SETTINGS_DEF[key].default
    if DEBUG_SETTINGS:
        print("Default settings: ", settings)


func save_settings():
    var file = File.new()
    file.open(SETTINGS_PATH, File.WRITE)
    file.store_line(to_json(settings))
    file.close()


func load_settings() -> void:
    var file = File.new()

    if not file.file_exists(SETTINGS_PATH):
        if DEBUG_SETTINGS:
            print("No settings file exists, using defaults")
        return

    file.open(SETTINGS_PATH, File.READ)
    var new_settings = parse_json(file.get_as_text())
    file.close()

    # in case settings format has changed, this is better than just copying
    for key in new_settings:
        if settings.has(key):
            settings[key] = new_settings[key]
    save_settings()
    if DEBUG_SETTINGS:
        print("Loaded settings from file")
        print(settings)
