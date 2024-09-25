extends Node2D

var curr_posn = 0
var inputs_filled = false
signal done(first_name, last_name, username, computer_name)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	pass # Replace with function body.
	await get_tree().create_timer(0.05).timeout
	$VBoxContainer/Label.show()
	await get_tree().create_timer(0.05).timeout
	$VBoxContainer/Label2.show()
	await get_tree().create_timer(0.05).timeout
	$VBoxContainer/CenterContainer/HBoxContainer/VBoxContainer.show()
	$VBoxContainer/CenterContainer/HBoxContainer/VBoxContainer2.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("TitleDown"):
		curr_posn += 1
		curr_posn = clamp(curr_posn, 0, 2 + int(inputs_filled))
	elif Input.is_action_just_pressed("TitleUp"):
		curr_posn -= 1
		curr_posn = clamp(curr_posn, 0, 2 + int(inputs_filled))
	elif inputs_filled and curr_posn == 3 and Input.is_action_just_pressed("TitleEnter"):
		done.emit(%FirstName.text, %LastName.text, %Username.text, %ComputerName.text)
		print("signal emitted")
	if curr_posn == 0:
		%FirstName.grab_focus()
	elif curr_posn == 1:
		%LastName.grab_focus()
	elif curr_posn == 2:
		%Username.grab_focus()
		%AcceptRect.color.b8 = 0
		%AcceptRect.color.r8 = 0
		%AcceptRect.color.g8 = 0
	elif curr_posn == 3:
		%Username.release_focus()
		%AcceptRect.color.b8 = 56
		%AcceptRect.color.r8 = 56
		%AcceptRect.color.g8 = 56
		
	inputs_filled = len(%FirstName.text) > 0 and len(%LastName.text) > 0 and len(%Username.text) > 0
	if len(%Username.text) > 0:
		%ComputerName.text = ((%Username.text) + "_freecisc")
	else:
		%ComputerName.text = ""
	if inputs_filled:
		%AcceptRect.show()
	else:
		%AcceptRect.hide()
	
