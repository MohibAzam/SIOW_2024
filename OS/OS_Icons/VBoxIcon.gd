extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	var icon_size = $Portion1.size
	print(icon_size)
	
	add_theme_constant_override("separation", 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
