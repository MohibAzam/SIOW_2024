extends Node2D

"""
Script to handle the Desktop node (which effectively encloses much of the
gameplay)
"""

# TODO: Desktop should also have:
# - An area showing the AI's profile/mood and their internal monologues
# - Make sure we have the ability to transition to more glitchier scenes
# and cutscenes!

# The set of applications that are currently active
var active_window_set = []
var window_inds = []

var base_x_posns = [100, 350, 100, 400, 700]
var base_y_posns = [50, 60, 300, 310, 320]

var click_enabled = true

var terminal_ready = false

signal text_done
signal opening_email(subject, read)

signal email_app_opened

func _determine_location():
	var window_ind = 0
	while window_ind in window_inds:
		window_ind += 1
	var offset = 50 * int(window_ind / 5)
	var x_posn = base_x_posns[window_ind % 5] + offset
	var y_posn = base_y_posns[window_ind % 5] + offset
	window_inds.append(window_ind)
	return [x_posn, y_posn, window_ind]


func _handle_close(app_name: String) -> void:
	var str_split = app_name.split("_")
	var actual_app_name = str_split[0]
	var window_ind = int(str_split[1])
	active_window_set.erase(actual_app_name)
	window_inds.erase(window_ind)
	var target_node = get_node(app_name)
	target_node.hide()
	target_node.queue_free()

func _open_app(app_name, node_path, allow_multi_spawn=false):
	if (app_name in active_window_set) and not allow_multi_spawn:
		push_warning("App cannot be spawned, it already exists!")
		return false

	var node_template = load(node_path)
	var app_node = node_template.instantiate()
	var loc_outs = _determine_location()
	var x_posn = loc_outs[0]
	var y_posn = loc_outs[1]
	var window_ind = loc_outs[2]
	app_node.position.x = x_posn
	app_node.position.y = y_posn
	app_node.name = app_name + "_" + str(window_ind)
	active_window_set.append(app_name)
	add_child(app_node)
	app_node.closing_app.connect(_handle_close)
	return app_node
		
	
func _handle_spawn_reply(subject, sender, body, replied_flag):
	var email_view = _open_app("EmailView", "res://Email_App/EmailApp.tscn")
	if email_view:
		email_view.subject = subject
		email_view.sender = sender
		email_view.body = body
		email_view.replied_flag = replied_flag
		opening_email.emit(subject, )
	

func _open_email_app(app_name):
	if click_enabled:
		var email_node = _open_app("Email", "res://Email_App/EmailList.tscn")
		if email_node:
			email_node.spawn_email_entry.connect(_handle_spawn_reply)
			email_app_opened.emit()
	

func _open_script_app(app_name):
	if click_enabled: var script_node = _open_app("Script", "res://Runner_App/ScriptRunning.tscn", true)
	
func _terminal_ready(): terminal_ready = true

func _handle_text_done(): text_done.emit()

func add_task(task_name): $TodoList.add_task(task_name)

func mark_done(task_name): $TodoList.mark_done(task_name)

# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect all of the icons to the runner script
	$Email.clicked.connect(_open_email_app)	
	$CompresZoo.clicked.connect(_open_script_app)
	$AiTerminal.ready_for_use.connect(_terminal_ready)
	$AiTerminal.text_done.connect(_handle_text_done)
	$StaticOverlay.play()
	pass # Replace with function body.
	
func add_animation(clear_anim = true):
	if clear_anim:
		$StaticOverlay.hide()
		
	pass

func write_text(given_text, base_timer=2, init_kwargs={}): $AiTerminal.write_text(given_text, base_timer, init_kwargs)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
