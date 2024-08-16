extends Node2D

# Current position on the list
var curr_posn = 0
var menu_items = ["Begin", "Load", "Setup", "About", "Exit"]

signal next_menu(action_to_take)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Handle key presses
	if Input.is_action_just_pressed("TitleEnter"):
		var action_to_take = menu_items[curr_posn]
		next_menu.emit(action_to_take)
	elif Input.is_action_just_pressed("TitleDown"):
		curr_posn = ((curr_posn + 1) % 5) 
	elif Input.is_action_just_pressed("TitleUp"):
		curr_posn = ((curr_posn - 1) % 5) 
	
	# Update bar position
	$MenuRect/Selector.position.x = 32
	$MenuRect/Selector.position.y = get_node("MenuRect/VBoxContainer/" + menu_items[curr_posn]).position.y + 58
