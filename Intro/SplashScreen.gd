extends Node2D

# This is the text the splash screen will have...
var line1 = "Created for Mental Health Game Dev Champions 2024"
var line2 = "Beginning initial tests"
var line3 = "Validating data via checksums"
var line4 = "Confirming assets"
var line5 = "Confirming target computer's capabilities"
var line6 = "Boot-up tests successful. Now launching…"
var done = "[OK]"
var running = "[RUNNING]"

# Emit this signal once the splash screen has finished
signal done_splash
signal done_run_test

# Control the time this way to make things easier to debug
var time_unit = 0.1

func _run_test(text_to_use):
	# Save the old text for later
	var old_text = $VBox/Text.text
	
	# Update the text and save it as well
	$VBox/Text.text += ("\n" + running + " " + text_to_use)
	var new_text = $VBox/Text.text
	
	# Move the dots in the textbox for three seconds.
	$VBox/Text.text = (new_text + ".")
	await get_tree().create_timer(0.5*time_unit).timeout
	$VBox/Text.text = (new_text + "..")
	await get_tree().create_timer(0.5*time_unit).timeout  
	$VBox/Text.text = (new_text + "...")
	await get_tree().create_timer(0.5*time_unit).timeout
	$VBox/Text.text = (new_text + ".")
	await get_tree().create_timer(0.5*time_unit).timeout
	$VBox/Text.text = (new_text + "..")
	await get_tree().create_timer(0.5*time_unit).timeout  
	$VBox/Text.text = (new_text + "...")
	await get_tree().create_timer(0.5*time_unit).timeout    
	
	# Finish
	$VBox/Text.text = (old_text + "\n" + done + " " + text_to_use)
	await get_tree().create_timer(0.5*time_unit).timeout
	done_run_test.emit()


# Called when the node enters the scene tree for the first time.
func _ready():
	# Begin by hiding the text
	$VBox.hide()

# Called when we want to do the intro splash screen
func run_splash():
	# Show the text and display first line
	$VBox/Text.text = line1
	$VBox.show()
	await get_tree().create_timer(1.0*time_unit).timeout  
	
	# Show the text and display second line
	$VBox/Text.text += ("\n⠀\n" + line2 + "\n⠀")
	await get_tree().create_timer(1.0*time_unit).timeout  

	# Show the 3rd-5th line
	_run_test(line3)
	await done_run_test
	
	_run_test(line4)
	await done_run_test
	
	_run_test(line5)
	await done_run_test
	
	# Show the last line
	$VBox/Text.text += ("\n⠀\n" + line6)
	await get_tree().create_timer(3.0*time_unit).timeout  
	
	# Change the font and then emit the signal to exit
	$VBox/Text.set("theme_override_fonts/font", load("res://Fonts/Mx437_CL_Stingray_8x16.ttf"))
	await get_tree().create_timer(0.125*time_unit).timeout  
	$VBox/Text.set("theme_override_font_sizes/font_size", 32)
	await get_tree().create_timer(1.0*time_unit).timeout 
	done_splash.emit()
	
func run_exit():
	# Show the text for exiting
	$VBox/Text.text = "Now exiting..."
	$VBox.show()
	await get_tree().create_timer(1.0*time_unit).timeout  
	
	get_tree().quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
