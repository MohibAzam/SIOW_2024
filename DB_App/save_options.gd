extends Window

signal saving(save_func)
	
func _on_pdf_pressed() -> void: _make_save_func('.pdf')
func _on_csv_pressed() -> void: _make_save_func('.csv')
	
func _make_save_func(save_type):
	var save_func = func(fname, data):
		var date_append = "_" + str(GlobalVars.curr_month) + "_" + str(GlobalVars.curr_day)
		var curr_time = GlobalVars.get_time()
		var time_append = "_" + str(curr_time[0]) + "_" + str(curr_time[1])
		var new_fname = fname + date_append + time_append + save_type
		GlobalVars.stored_files[new_fname] = data
		return new_fname
	saving.emit(save_func)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
