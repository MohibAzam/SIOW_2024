extends Window

var _fname: String = ""
var _text : String = ""

signal closing_app(app_name: String)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.title = "Notepad — " + _fname
	$ScrollContainer/Text.text = _text

func _load_file(fname, text="") -> void:
	_fname = fname
	if text == "":
		_text = GlobalVars.stored_files[_fname]
	else:
		_text = text

func _on_close_requested() -> void:
	closing_app.emit(self.name)
	pass # Replace with function body.
