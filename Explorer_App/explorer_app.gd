extends Window

var _curr_dir: String = ""
var filter_types = []
var _visible_files = []
var _visible_files_clean = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _find_visible_files() -> void:
	_visible_files = [] # First, empty the list of viewable files
	var all_files = GlobalVars.stored_files.keys()
	for file in all_files:
		if _curr_dir == file.substr(0, len(_curr_dir)):
			_visible_files.append(file)
			_visible_files_clean.append(file.split('/')[0])

func _handle_click() -> void:
	pass

func _update_files() -> void:
	for file in _visible_files_clean:
		var new_entry = load("res://Explorer_App/Explorer_entry.tscn")
		var entry_scene = new_entry.instantiate()
		entry_scene.set_entry(file)
		$Scroll/VBox.add_child(entry_scene)
		entry_scene.clicked.connect("_handle_click")

func set_dir(dir: String):
	_curr_dir = dir
	_find_visible_files()
	_update_files()
