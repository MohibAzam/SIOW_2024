extends Node2D

"""
Script to handle the Desktop node (which effectively encloses much of the
gameplay. I don't think this should be the "Game" node since we want to 
be able to swap to menus, cutscenes, and results/loading screens when needed)
"""

# TODO: Desktop should also have:
# - A Taskbar Scene
# - A clock (and general time progression!! Maybe the time should be global?)
# - An area showing the AI's profile/mood and their internal monologues
# - Make sure we have the ability to transition to more glitchier scenes
# and cutscenes!

# TODO: Don't forget to change the images for the Save and Email icons!!!!

# The set of applications that are currently active
var active_window_set = {}

# Remove an application for the set of active ones when its window gets closed
func _handle_close(app_name):
	active_window_set.erase(app_name)

# Function to spawn in a window when an icon gets clicked
func _handle_icon_signal(text_data):
	# Do not spawn in another window if the application is already active
	if active_window_set.has(text_data):
		print_debug("Window is already active!")
		return
	
	# A lambda function for spawning in the window based on some inputted 
	# information (used for code abstraction)
	var window_lambda = func(app_name, x_posn, y_posn):
		# Set up the window node
		var path = load("res://OS/OS_Apps/AppWindow.tscn")
		var window = path.instantiate()
		window.set_app(app_name)
		
		# Set up window positions
		window.position.x = x_posn
		window.position.y = y_posn
		
		# Connect any signals
		window.CloseWindow.connect(_handle_close)
		
		# Add the window as a child 
		add_child(window)
		
		# Add window to set of active windows (value doesn't matter, hence null)
		active_window_set[text_data] = null

	# Some calls to the lambda function for each icon
	# TODO: Come up with a different strategy for where we place windows when
	# they get spawned in...
	if text_data == "Email":
		window_lambda.call("Email", 200, 200)
	else:
		window_lambda.call("Save", 600, 400)
	

# Called when the node enters the scene tree for the first time.
func _ready():
	# Load in the icon path
	var icon_obj_path = preload("res://OS/OS_Icons/Icon.tscn")
	
	# Lambda function to call to setup each icon node we want on the desktop
	var load_lambda = func(icon_img, icon_name, x_posn, y_posn):
		# Set up the icon node
		var icon = icon_obj_path.instantiate()
		icon.set_image("res://OS/OS_Icons/Icon_Assets/" + icon_img)
		icon.set_text(icon_name)
		
		# Position the icon
		icon.position.x = x_posn
		icon.position.y = y_posn
		
		# Add the icon as a child and setup the signal for clicking it
		add_child(icon)
		icon.clicked.connect(_handle_icon_signal)
	
	# Setup the Save and Email icons
	# TODO: Find a way to position these icons without hardcoding
	load_lambda.call("save_icon.png", "Save", 32, 32)
	load_lambda.call("email.png", "Email", 32, 192)

	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
