extends HBoxContainer

signal clicked(fname)
var mouse_on = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if mouse_on and Input.is_action_just_pressed("MouseClick"):
		clicked.emit($Fname.text)

func set_entry(fname, override_icon=false):
	$Fname.text = fname
	# TODO: Add some scripting to load in the icon image

func _on_mouse_entered() -> void:
	mouse_on = true

func _on_mouse_exited() -> void:
	mouse_on = false
