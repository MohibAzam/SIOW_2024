extends Window


var curr_time: int = 0 # 
var goal_time: float = 200. # The goal time 
var start_hour = 0
var start_min = 0
var done: bool = false # Determines if we're done incrementing
var paused: bool = false
var timer_ready: bool = true # Determines if we should start incrementing time
var curr_bar: String = "░░░░░░░░░░░░░░░░░░░░░░░░░"
var latest_progress: int = 0

var curr_posn = Vector2(0, 0)

var inner_window

signal closing_app

# Called when the node enters the scene tree for the first time.
func _ready():
	# Ensure that the background is the same size as the window area.
	$Background.size.x = self.size.x
	$Background.size.y = self.size.y
	curr_posn.x = self.position.x
	curr_posn.y = self.position.y
	pass # Replace with function body.

func set_goal_time(given_time=200):
	goal_time = given_time
	_update_bar()
	timer_ready = true

# Set the text of our label
func set_text():
	pass
	

# Set the current time of our progress bar
func set_time(given_time):
	curr_time = given_time
	_update_bar()

func _update_bar():
	if curr_time >= goal_time:
		curr_bar = "Done!"
		done = true
	else:
		print(curr_time / goal_time)
		while latest_progress < int(25 * (curr_time / goal_time)):
			curr_bar[latest_progress] = "█"
			latest_progress += 1
	$Background/VBoxContainer/TextProgBar.text = curr_bar

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Increment our window's timer if we're not yet done 
	if InputEventMouseMotion:
		self.position.x = curr_posn.x
		self.position.y = curr_posn.y
	
	if ready and not done and not paused:
		curr_time += 1

		# Update the progress label accordingly
		_update_bar()

func _handle_inner_window(should_close):
	# Regardless of selection, close the active window
	inner_window.hide()
	remove_child(inner_window)
	inner_window.call_deferred("queue_free")
	paused = false
	if should_close:
		closing_app.emit()

func _on_close_requested():
	# If we're not done yet, emit a window noting that we're not done 
	# Otherwise, call the close window function
	if paused:
		pass
	elif not done:
		var confirm = load("res://OS/ConfirmWindow.tscn")
		inner_window = confirm.instantiate()
		inner_window.position.x = self.position.x + int(self.size.x/4)
		inner_window.position.y = self.position.y + int(self.size.y/2)
		add_child(inner_window)
		inner_window.got_confirm.connect(_handle_inner_window)
		paused = true
	else:
		closing_app.emit()
