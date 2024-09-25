extends HBoxContainer

var button_num = 0 # Numbeer of option buttons
var button_size = 100 # Size of the buttons
var per_row = 3
var button_color = Color(0.75, 0.75, 0.75)
var button_font_color = Color(0, 0, 0)
var ind_dict = {}

var button_row_template = preload('res://Email_App/EmailOptionRow.tscn')

signal option_selected(option)
signal option_hovered(option)
signal option_exited(option)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _handle_option_clicked(option): option_selected.emit(option, ind_dict[option])
func _handle_option_hovered(option): option_hovered.emit(option)
func _handle_option_dehovered(option): option_exited.emit(option)

func _make_planned_row(planned_row, button_size):
	var new_row = button_row_template.instantiate()
	new_row.make_new_buttons(planned_row, button_size)
	%VBox.add_child(new_row)
	new_row.row_option_clicked.connect(_handle_option_clicked)
	new_row.row_option_hovered.connect(_handle_option_hovered)
	new_row.row_option_dehovered.connect(_handle_option_dehovered)

func set_options(options_list, new_per_row = NAN, new_button_size = NAN) -> void:
	if not is_nan(new_per_row):
		per_row = new_per_row
	if not is_nan(new_button_size):
		button_size = new_button_size	
	ind_dict = {}
	var planned_row = []
	for i in range(len(options_list)):
		var option = options_list[i]
		planned_row.append(option)
		if len(planned_row) >= per_row:
			_make_planned_row(planned_row, button_size)
			planned_row = []
		ind_dict[option] = i
	if len(planned_row) > 0:
		_make_planned_row(planned_row, button_size)

func clear_options() -> void:
	var children = %Vbox.get_children()
	for child in children:
		%Vbox.remove_child(child)
		child.queue_free()
	ind_dict = {}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
