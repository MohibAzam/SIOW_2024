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

var panic_circ_template = preload("res://OS_Core/panic_circle.tscn")
var wrapper_template = preload("res://OS_Core/AppWrapper.tscn")

var size_dict = {
	"Email": Vector2(400, 300)
}

signal text_done
signal opening_email(subject, read)
signal closing_app(name)
signal email_app_opened

signal done_fade
signal done_red_mild
signal done_red_strong

func _determine_location():
	var window_ind = 0
	while window_ind in window_inds:
		window_ind += 1
	var offset = 50 * int(window_ind / 5)
	var x_posn = base_x_posns[window_ind % 5] + offset
	var y_posn = base_y_posns[window_ind % 5] + offset
	window_inds.append(window_ind)
	return [x_posn, y_posn, window_ind]

func fade_to_black() -> void:
	var alpha_val = 0
	var black_color = Color(0, 0, 0)
	$BlackOverlay.show()
	while alpha_val <= 240:
		var new_style = $BlackOverlay.get("theme_override_styles/panel")
		black_color.a8 = alpha_val
		new_style.set_bg_color(black_color)
		$BlackOverlay.set("theme_override_color/bg_color", new_style)
		alpha_val += 1
		await get_tree().create_timer(0.016).timeout

func show_taskbar(): $Taskbar.show_taskbar()

func add_score(): $Taskbar.get_node("%Score").show()

func add_red_tint_mild(alpha_cap = 96, alpha_start = 0) -> void:
	var alpha_val = alpha_start
	var red_color = Color(1, 0.9, 0.9)
	$RedTint.show()
	while alpha_val <= alpha_cap:
		var new_style = $RedTint.get("theme_override_styles/panel")
		red_color.a8 = alpha_val
		new_style.set_bg_color(red_color)
		$RedTint.set("theme_override_color/bg_color", new_style)
		alpha_val += 1
		await get_tree().create_timer(0.5).timeout
	
func add_red_tint_strong(chain_mild = false, alpha_cap = 96) -> void:
	if chain_mild: await add_red_tint_mild(alpha_cap)
	var gb_val = 0.9
	var red_color = Color(1, gb_val, gb_val)
	$RedTint.show()
	while gb_val > 0:
		var new_style = $RedTint.get("theme_override_styles/panel")
		red_color.a8 = alpha_cap
		new_style.set_bg_color(red_color)
		$RedTint.set("theme_override_color/bg_color", new_style)
		gb_val -= 0.01
		await get_tree().create_timer(0.05).timeout

func panic_time():
	# Quick fadeout
	$RedTint.hide()
	$BlackOverlay.hide()
	%PanicOverlay.show()
	var panic_color = Color(0, 0, 0)
	var a_val = 0 
	var new_style = %PanicOverlay.get("theme_override_styles/panel")
	while a_val < 256:
		a_val += 64
		panic_color.a8 = a_val
		new_style.set_bg_color(panic_color)
		%PanicOverlay.set("theme_override_color/bg_color", new_style)
		await get_tree().create_timer(0.01).timeout
		
	# Setup all the panic circles		
	var rand_x = [0, 150, 300, 450, 600, 750, 900, 1050]
	var rand_y = [0, 150, 300, 450, 600, 750]
	var panic_count = 0
	for i in range(10):
		var base_x_val = i * 120
		for j in range(7):
			var base_y_val = j * 120 
			var chosen_x = base_x_val + randi_range(-75, 75)
			var chosen_y = base_y_val + randi_range(-75, 75)
			var new_panic = panic_circ_template.instantiate()
			new_panic.z_index = 25
			new_panic.name = "panic_" + str(panic_count)
			new_panic.position.x = chosen_x 
			new_panic.position.y = chosen_y
			$CanvasLayer.add_child(new_panic)
			new_panic.update_size(randi_range(70, 74))
			new_panic.kirby = randi_range(32, 128)
			panic_count += 1
				
	# Create the blur too
	for i in range(4):
		a_val -= 24
		panic_color.a8 = a_val
		panic_color.r8 += 61
		panic_color.b8 += 60 
		panic_color.g8 += 60
		
		new_style.set_bg_color(panic_color)
		%PanicOverlay.set("theme_override_color/bg_color", new_style)
		await get_tree().create_timer(0.01).timeout
		
func end_panic():
	pass

func reset_overlays(): $BlackOverlay.hide()

func _handle_close(app_name: String) -> void:
	# print(app_name)
	var str_split = app_name.split("_")
	var actual_app_name = str_split[0]
	var window_ind = int(str_split[1])
	closing_app.emit(actual_app_name)
	active_window_set.erase(actual_app_name)
	window_inds.erase(window_ind)
	var target_node = get_node(app_name)
	target_node.hide()
	target_node.queue_free()
	
	# If we're closing the email app, close all other email-related stuff
	# while we're at it
	if actual_app_name == "Email":
		var children = self.get_children()
		for child in children:
			pass
			# print(child.name)
			# if child.name.substr(0, 5) == "Email": _handle_close(child.name)

func _open_app(app_name, node_path, allow_multi_spawn=false):
	if (app_name in active_window_set) and not allow_multi_spawn:
		push_warning("App cannot be spawned, it already exists!")
		return false

	# Create the app contents
	var node_template = load(node_path)
	var app_node = node_template.instantiate()
	var loc_outs = _determine_location()
	var x_posn = loc_outs[0]
	var y_posn = loc_outs[1]
	var window_ind = loc_outs[2]
	
	# Create and position the actual window
	var window = wrapper_template.instantiate()
	window.position.x = x_posn
	window.position.y = y_posn
	window.name = app_name + "_" + str(window_ind)
	active_window_set.append(app_name)
	add_child(window)
	window.closing_app.connect(_handle_close)
	return [app_node, window]
		
func _handle_writing(text, button_ind): pass
func _handle_deleting(): pass
func _handle_doing_something_w_attach(): pass
func _handle_attaching(): pass
func _handle_sending(): pass

func _handle_spawn_reply():
	var app_nodes = _open_app("EmailView", "res://Email_App/EmailReply.tscn")
	if app_nodes:
		pass

func _handle_spawn_email(subject, sender, body, replied_flag, read_flag):
	print("attempted to spawn a reply")
	var app_nodes = _open_app("EmailView", "res://Email_App/EmailApp.tscn")
	if app_nodes:
		var email_view = app_nodes[0]
		email_view.subject = subject
		email_view.sender = sender
		email_view.body = body
		email_view.replied_flag = replied_flag
		opening_email.emit(subject, read_flag)
	
		var window = app_nodes[1]
		window.add_app(email_view)
		window.update_size(400, 300)
		window.set_title(subject)
		window.show_app()

func _open_email_app(app_name):
	if click_enabled:
		var app_nodes = _open_app("Email", "res://Email_App/EmailList.tscn")
		if app_nodes:
			var email_node = app_nodes[0]
			email_node.spawn_email_entry.connect(_handle_spawn_email)
			email_app_opened.emit()
			
			var window = app_nodes[1]
			window.add_app(email_node)
			window.update_size(400, 300)
			window.set_title("Email Inbox")
			window.show_app()
	
func _open_script_app(app_name):
	if click_enabled: var script_node = _open_app("Script", "res://Runner_App/ScriptRunning.tscn", true)
	
func _terminal_ready(): terminal_ready = true

func _handle_text_done(): text_done.emit()

func add_task(task_name): $TodoList.add_task(task_name)

func mark_done(task_name): $TodoList.mark_done(task_name)

# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect all of the icons to the runner script
	GlobalVars.push_initial_emails()
	
	$Email.clicked.connect(_open_email_app)	
	$CompresZoo.clicked.connect(_open_script_app)
	$AiTerminal.ready_for_use.connect(_terminal_ready)
	$AiTerminal.text_done.connect(_handle_text_done)
	$StaticOverlay.play()
	pass # Replace with function body.
	
func add_animation(clear_anim = true): if clear_anim: $StaticOverlay.hide()

func write_text(given_text, base_timer=2, init_kwargs={}):
	$AiTerminal.write_text(given_text, base_timer, init_kwargs)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
