extends MarginContainer

var button_template = preload('res://Email_App/EOptionButton.tscn')
var row_buttons = []
var _button_size = 0

signal row_option_clicked(option)
signal row_option_hovered(option)
signal row_option_dehovered(option)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _handle_button_hover(option) -> void: row_option_hovered.emit(option)
func _handle_button_dehover(option) -> void: row_option_dehovered.emit(option)
func _handle_button_clicked(option) -> void: row_option_clicked.emit(option)

func set_button_size(new_size: float) -> void:
	_button_size = new_size
	for child in self.get_children():
		child.custom_minimium_size.x = _button_size

func make_new_buttons(options, new_size=100):
	for option in options:
		var new_button = button_template.instantiate()
		new_button.text = option
		new_button.custom_minimium_size.x = _button_size
		%HBox.add_child(new_button)
		new_button.clicked_name.connect(_handle_button_clicked)
		new_button.hovered_name.connect(_handle_button_hover)
		new_button.exited_name.connect(_handle_button_dehover)
