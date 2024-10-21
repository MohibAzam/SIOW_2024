extends Node2D

var curr_scene
var ch1_template

func _handle_begin():
	var setup_screen = load("res://Intro/TitleScreen.tscn")
	var new_scene = setup_screen.instantiate()
	add_child(new_scene)
	curr_scene.hide()
	remove_child(curr_scene)
	curr_scene.call_deferred("queue_free")
	curr_scene = new_scene
	
func _start_ch1_transition():
	# Re-enable mouse input
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	# First load in the transition into Chapter 1
	var intro_screen = load("res://Chapter1/IntroTransition.tscn")
	var new_scene = intro_screen.instantiate()
	add_child(new_scene)
	remove_child(curr_scene)
	curr_scene.call_deferred("queue_free")
	curr_scene = new_scene
	curr_scene.show()
	curr_scene.done_transition.connect(_start_chapter_1)
	
	# Preload Chapter 1 to save some time	
	ch1_template = preload("res://Chapter1/Chapter1Intro.tscn")
	
	
func _start_chapter_1():
	var new_scene = ch1_template.instantiate()
	add_child(new_scene)
	remove_child(curr_scene)
	curr_scene.call_deferred("queue_free")
	curr_scene = new_scene
	curr_scene.show()
	# curr_scene.done_transition.connect(_start_chapter_2)
	
# func _start_chapter

func _handle_title_menus(selection):
	if selection == "Exit":
		var exit_scene = load("res://Intro/SplashScreen.tscn")
		var new_scene = exit_scene.instantiate()
		add_child(new_scene)
		curr_scene.hide()
		remove_child(curr_scene)
		curr_scene.call_deferred("queue_free")
		curr_scene = new_scene
		curr_scene.run_exit()
		
	# If we get a call to start the game...
	if selection == "Begin":
		# Go to our initialization screens.  
		var intro_screen = load("res://Intro/SetupScreen.tscn")
		var new_scene = intro_screen.instantiate()
		add_child(new_scene)
		remove_child(curr_scene)
		curr_scene.call_deferred("queue_free")
		curr_scene = new_scene
		curr_scene.show()
		curr_scene.setup_done.connect(_start_ch1_transition)
		pass
	
func _goto_title():
	var title_screen = load("res://Intro/TitleScreen.tscn")
	var new_scene = title_screen.instantiate()
	add_child(new_scene)
	curr_scene.hide()
	remove_child(curr_scene)
	curr_scene.call_deferred("queue_free")
	curr_scene = new_scene
	curr_scene.next_menu.connect(_handle_title_menus)

# Called when the node enters the scene tree for the first time.
func _ready():
	# Disable mouse input to begin
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	# Start by loading the splash screen
	var splash_screen = load("res://Intro/SplashScreen.tscn")
	curr_scene = splash_screen.instantiate()
	add_child(curr_scene)
	curr_scene.done_splash.connect(_goto_title)
	curr_scene.run_splash()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
