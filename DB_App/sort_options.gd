extends Window

signal sort_chosen(sort_func)
signal sort_warning()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func add_columns(cols): for col in cols: %Column.add_item(col)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	# Make sure a valid column and sorting type is chosen
	if %Column.selected == 0 or %Type.selected == 0:
		sort_warning.emit()
		return
	
	var chosen_column_name = %Column.get_item_text(%Column.selected)
	
	var sorting_func = func(full_dict, target_col_name, check_type, sort_method):
		# Get the inds of the column (prior to sort) and check if it's the correct type
		# If we get a type mismatch, return an error
		var ind_dict = {}
		var target_col = full_dict[target_col_name]
		for i in range(len(full_dict[target_col_name])):
			var entry = full_dict[target_col]
			if not (typeof(entry) == check_type):
				return false
			else:
				ind_dict[entry] = i
				
		# Sort the array
		target_col.sort_custom(sort_method)
		
		# Get the new indices
		var new_inds = []
		for entry in target_col: new_inds.append(ind_dict[entry])
		
		# Sort the other columns
		for column_name in full_dict.keys():
			var initial_column = full_dict[column_name]
			var new_column = []
			for ind in new_inds: new_column.append(initial_column[ind])
			full_dict[column_name] = new_column
			
		# Sorting is done!
		return full_dict
		
	sort_chosen.emit(sorting_func)
