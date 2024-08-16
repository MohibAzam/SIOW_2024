extends Node2D

<<<<<<< Updated upstream

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

=======
var curr_scene

func _handle_begin():
	var setup_screen = load("res://Intro/TitleScreen.tscn")
	var new_scene = setup_screen.instantiate()
	add_child(new_scene)
	curr_scene.hide()
	remove_child(curr_scene)
	curr_scene.call_deferred("queue_free")
	curr_scene = new_scene
	
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
	# Start by loading the splash screen
	var splash_screen = load("res://Intro/SplashScreen.tscn")
	curr_scene = splash_screen.instantiate()
	add_child(curr_scene)
	curr_scene.done_splash.connect(_goto_title)
	curr_scene.run_splash()
>>>>>>> Stashed changes

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
