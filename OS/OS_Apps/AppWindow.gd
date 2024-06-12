extends Node2D

"""
A script to handle the AppWindow node, which is effectively a generic window
within which various applications can be shown
The applications themeselves are separate nodes. Each Window will instantiate
*one* of these applications as a child.  
"""
# TODO: When clicked, adjust the overlapping so that this window is the focus
# above all others! 
# TODO: Is it proper Godot practice to have a separate function to handle inputs
# for initialization rather than doing everything in the ready function?

# Application name
var _app_name = ""

# Emit this signal (with the app name) when closing the window
signal CloseWindow(app_name) 


# Set the app for this window. This should be called immediately when instantiated
func set_app(app_name="BlankWindow"):
	# Sanity check! Do NOT set a window if the app_name is empty!
	# TODO: If you want the window to be able to swap the currently viewed app,
	# (idk if we'll need this feature), maybe just destroy the child first?
	if not(_app_name == ""):
		print_debug("This window already has an application set!")
		return
	
	# Load in the desired app and instantiate it
	# NOTE: If the app of the given name doesn't exist, just load in the
	# placeholder window node (this will not occur in the final game, this is
	# just to prevent crashing and make development easier)
	# NOTE: Do NOT change the _app_name to BlankWindow, just keep the original
	# name. This is needed so that Desktop.gd knows which application can 
	# have a new window generated.
	var path = load("res://OS/OS_Apps/" + str(app_name) + ".tscn")
	if path == null:
		path = load("res://OS/OS_Apps/BlankWindow.tscn")
	self._app_name = app_name
	var app_inst = path.instantiate()
	
	# Add the app to the node and adjust the window header so that it stretches
	# to the exact length of the application
	# TODO: Why isn't this working with the email app?
	$VBoxContainer/AppPanel.add_child(app_inst)
	$VBoxContainer/Header.custom_minimum_size = Vector2(app_inst.size.x, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Close the window is the X is pressed and delete it from the node tree.
	if $VBoxContainer/Header/Close.is_pressed():
		CloseWindow.emit(_app_name)
		queue_free()
