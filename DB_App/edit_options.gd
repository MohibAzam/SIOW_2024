extends Window

signal editing(edit_func)
signal op_failed(message)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func add_columns(cols):
	for col in cols:
		%Col1.add_item(col)
		%Col2.add_item(col)

func _handle_show() -> void:
	if %BasicOption.selected == 1:
		%Arithmetic.show()
		%Logical.hide()
		%String.hide()
		%Col1.hide()
		%Col2.hide()
		%Value.hide()
	elif %BasicOption.selected == 2:
		%Arithmetic.hide()
		%Logical.show()
		%String.hide()
		%Col1.hide()
		%Col2.hide()
		%Value.hide()
	elif %BasicOption.selected == 3:
		%Arithmetic.hide()
		%Logical.hide()
		%String.show()
		%Col1.hide()
		%Col2.hide()
		%Value.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_handle_show()

func _arithmetic_signal():
	var arith_op
	var arith_op_name = ""
	if %Arithmetic.selected == 1:
		arith_op = func(a, b): return a + b
		arith_op_name = "add"
	elif %Arithmetic.selected == 2:
		arith_op = func(a, b): return a - b
		arith_op_name = "sub"
	elif %Arithmetic.selected == 3:
		arith_op = func(a, b): return a * b
		arith_op_name = "mul"
	else:
		arith_op =func(a, b): return a / b
		arith_op_name = "div"
	var col_1_text = %Col1.get_item_text()
	var col_2_text = %Col2.get_item_text()
	
	var full_arith_func = func(data):
		var col_1 = data[col_1_text]
		var col_2 = data[col_2_text]
		var new_col = []
		
		for i in range(len(col_1)):
			var entry_1 = col_1[i]
			var entry_2 = col_2[i]
			if (typeof(entry_1) == TYPE_INT) and (typeof(entry_2) == TYPE_INT):
				new_col.append(arith_op.call(entry_1, entry_2))
			else:
				return [false, "Incorrect types found!"]
				
		var new_name = col_1_text + arith_op_name + col_2_text
		return [new_name, new_col]



func _on_edit_pressed() -> void:
	if %BasicOption.selected == 1:
		_arithmetic_signal()
	pass # Replace with function body.
