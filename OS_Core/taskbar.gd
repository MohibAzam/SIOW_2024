extends Node2D

var curr_score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# TODO: Get rid of Save/Load and instead just have Score on the left and Sun icon on the right.
# Or possibly even the other way around to mess with the player's attention....

func _handle_score():
	# Increment or decrement the score by 1 per frame if the score gets updated
	if curr_score < GlobalVars.get_score():
		curr_score += 1
	elif curr_score > GlobalVars.get_score():
		curr_score -= 1
	
	# Set the score in the label
	%Score.text = "Score: " + str(curr_score)
	
	# Change the color to red if the score is negative. Otherwise, it's black
	if curr_score == -1: %Score.set("theme_override_colors/font_color", Color(1, 0, 0))
	elif curr_score == 0: %Score.set("theme_override_colors/font_color", Color(0, 0, 0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_handle_score()
