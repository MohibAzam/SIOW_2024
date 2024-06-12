extends Node2D

"""
A script to handle a desktop icon that can be clicked to open a window
Note that the icon itself is handled as a button (this seems to be the
easiest way to do this coding-wise)
"""

# Name of the icon
var icon_name = ""

 # Emit this signal when the icon gets clicked; name is the name of the icon
signal clicked(icon_name)


# Called when the node enters the scene tree for the first time.
func _ready():
	# Set up the signal for this icon being clicked
	$TextureRect/VBoxIcon/Portion1/Button.pressed.connect(_handle_click)
	pass # Replace with function body.


# Set the image of the icon (so we don't have to manually define each icon!)
func set_image(img_path):
	var img = load(img_path)
	$TextureRect/VBoxIcon/Portion1/Button.icon = load(img_path)


# Set the text of the icon (beneath the image, note that this isn't clickable)
func set_text(text_str):
	$TextureRect/VBoxIcon/Portion2/IconName.text = text_str
	icon_name = text_str
	

# When this icon gets clicked, emit the signal
func _handle_click():
	clicked.emit(icon_name)
