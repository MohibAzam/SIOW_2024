extends Node2D

var curr_step = 0
var steps = ["Begin", "License Agreement", "Account Setup"]
var max_progress = [0, 50, 60, 75]
var show_next = [0, 5, 20, 40]
var time_unit = 0.1

var counter = 0
var counter_increment = 30
var bar_str = ""

var progress_counter
var warning_enter = false
var curr_body_node

var seconds_left = 5

signal setup_done

# Update the progress string.
# The current position will have an ○, done positions have a ●
# and upcoming steps will have an index attached
func _update_header_str():
	var header_str = ""
	var i = 0
	while i < len(steps):
		var inner_char
		if i < curr_step:
			inner_char = '●'
		elif i == curr_step:
			inner_char = '○'
		else:
			inner_char = str(i)
		header_str += "[" + inner_char + "] " + steps[i]
		i += 1
		if i < len(steps):
			header_str += " --- "
	$VBoxContainer/ProgressLabel.text = header_str

func _place_at_center():
	# Create horizontal and vertical offsets 
	print($ProgressLabel.size)
	var h_offset = ($MenuRect.size.x - $ProgressLabel.size.x)/2
	var v_offset = ($MenuRect.size.y - $ProgressLabel.size.y)/2
	$ProgressLabel.position.x = ($MenuRect.position.x + h_offset)
	$ProgressLabel.position.y = ($MenuRect.position.y + v_offset)

# Called when the node enters the scene tree for the first time.
func _ready():
	# First, we'll show the opening message after a pause
	_update_header_str()
	$VBoxContainer.hide()
	await get_tree().create_timer(time_unit).timeout
	$VBoxContainer.show()
	await get_tree().create_timer(time_unit).timeout
	var begin_text = load("res://Intro/BeginText.tscn")
	curr_body_node = begin_text.instantiate()
	add_child(curr_body_node)
	curr_body_node.position.x = 16
	curr_body_node.position.y = 128
	
func _done_name_entry(a, b, c, d):
	print("done")
	curr_body_node.queue_free()
	curr_body_node = null
	curr_step = 2.5
	_update_header_str()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Installation.visible and (len(bar_str) < max_progress[ceil(curr_step)]):
		counter += 1
		while int(counter / 30) > len(bar_str):
			bar_str += "█"
			$Installation/ProgressBarLabel.text = bar_str
	
	# Beginning phase
	# When Enter gets pressed, pause as we move on to the next phase
	if curr_step == 0 and Input.is_action_just_pressed("TitleEnter"):
		await get_tree().create_timer(time_unit).timeout
		curr_body_node.queue_free()
		curr_body_node = null
		await get_tree().create_timer(time_unit*0.25).timeout
		$Installation.show()
		curr_step = 0.5
		await get_tree().create_timer(time_unit*1).timeout
		_update_header_str()
	elif curr_step == 1:
		if not curr_body_node:
			_update_header_str()
			var warn_text = load("res://Intro/WarningLabel.tscn")
			curr_body_node = warn_text.instantiate()
			add_child(curr_body_node)
			curr_body_node.position.x = 16
			curr_body_node.position.y = 128
			await get_tree().create_timer(time_unit*3).timeout
			curr_body_node.accept_appear()
			warning_enter = true
		if warning_enter and Input.is_action_just_pressed("TitleEnter"):
			await get_tree().create_timer(time_unit).timeout
			curr_body_node.queue_free()
			curr_body_node = null
			curr_step = 1.5
			_update_header_str()
			await get_tree().create_timer(time_unit).timeout
	elif curr_step == 2:
		if not curr_body_node:
			_update_header_str()
			var account_setup = load("res://Intro/AccountSetup.tscn")
			curr_body_node = account_setup.instantiate()
			add_child(curr_body_node)
			curr_body_node.position.x = 16
			curr_body_node.position.y = 128
			await get_tree().create_timer(time_unit).timeout
			curr_body_node.done.connect(_done_name_entry)
	else:
		if len(bar_str) >= show_next[int(curr_step + 0.5)]:
			curr_step = int(curr_step + 0.5) 

	# TODO: Make sure to check that the current step is maximized as well!	
	if len(bar_str) == 75 and curr_step > 2 and seconds_left > 0:
		$VBoxContainer/ProgressLabel.hide()
		$Installation.hide()
		$InstallComplete.show()
		var base_str = "Installation Complete! This system will reset in "
		var append_str_arr = ["5 seconds.", "4 seconds.", "3 seconds.", "2 seconds.", "1 second."]
		var i = 5 - int(seconds_left)
		$InstallComplete.text = base_str + append_str_arr[i]
		print(base_str + append_str_arr[i])
		get_tree().paused = true
		await get_tree().create_timer(time_unit*5).timeout
		get_tree().paused = false
		$InstallComplete.text = base_str + append_str_arr[i]
		seconds_left = (seconds_left - 1)
		if seconds_left == 0:
			setup_done.emit()
