extends Node2D

# Current position on the list
var curr_posn = 0
var menu_items = ["Begin", "Load", "About", "Exit"] # Setup

signal next_menu(action_to_take)

var about_popup
var popup_active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	pass # Replace with function body.
	
func _place_at_center():
	# Create horizontal and vertical offsets 
	print($MenuRect.size)
	var h_offset = ($MenuRect.size.x - about_popup.size.x)/2
	var v_offset = ($MenuRect.size.y - about_popup.size.y)/2
	about_popup.position.x = ($MenuRect.position.x + h_offset)
	about_popup.position.y = ($MenuRect.position.y + v_offset)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Handle key presses
	if popup_active:
		if Input.is_action_just_pressed("TitleEnter"):
			about_popup.queue_free()
			popup_active = false
	else: 
		# If we hit Enter, that option will be selected.
		if Input.is_action_just_pressed("TitleEnter"):
			var action_to_take = menu_items[curr_posn]
			
			# If we pick About, then just do a popup rather than needing to 
			# go back to the Main Game node.
			if action_to_take == "About":
				var about = load("res://Intro/About.tscn")
				about_popup = about.instantiate()
				add_child(about_popup)
				print(about_popup.size)
				popup_active = true
				_place_at_center()

			# Otherwise, emit a signal so the main game can handle it. 
			next_menu.emit(action_to_take)

		# Otherwise, the arrow keys just handle movement
		elif Input.is_action_just_pressed("TitleDown"):
			curr_posn = ((curr_posn + 1) % len(menu_items)) 
		elif Input.is_action_just_pressed("TitleUp"):
			curr_posn = ((curr_posn - 1) % len(menu_items)) 
	
	# Update bar position
	$MenuRect/Selector.position.x = 32
	$MenuRect/Selector.position.y = get_node("MenuRect/VBoxContainer/" + menu_items[curr_posn]).position.y + 58
