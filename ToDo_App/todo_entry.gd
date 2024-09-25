extends MarginContainer

var _done: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%Mark.hide()
	pass # Replace with function body.
	
func set_item(item: String) -> void: %Item.text = item

func mark_done() -> void:
	_done = true
	%Mark.show()
	
func mark_undone() -> void:
	_done = false
	%Mark.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
