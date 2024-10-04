extends Window

var loaded_data

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _create_view():
	# Add row indices based on the size of the data
	

func load_data(fname) -> void:
	loaded_data = GlobalVars.stored_files[fname] # Load the data in the filename
	_create_view() # Adjust the data accordingly

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
