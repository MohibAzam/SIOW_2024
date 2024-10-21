extends Node2D

var curr_score = 0

var icon_dict = {
	0: preload("res://OS_Core/OtherAssets/sun8.png"),	
	1: preload("res://OS_Core/OtherAssets/sun8.png"),	
	2: preload("res://OS_Core/OtherAssets/sun8.png"),	
	3: preload("res://OS_Core/OtherAssets/sun7.png"),	
	4: preload("res://OS_Core/OtherAssets/sun6.png"),	
	5: preload("res://OS_Core/OtherAssets/sun5.png"),	
	6: preload("res://OS_Core/OtherAssets/sun4.png"),	
	7: preload("res://OS_Core/OtherAssets/sun3.png"),	
	8: preload("res://OS_Core/OtherAssets/sun2.png"),
	9: preload("res://OS_Core/OtherAssets/sun1.png"),
	10: preload("res://OS_Core/OtherAssets/sun1.png"),
	11: preload("res://OS_Core/OtherAssets/sun1.png"),
	12: preload("res://OS_Core/OtherAssets/sun1.png"),
	13: preload("res://OS_Core/OtherAssets/sun1.png"),
	14: preload("res://OS_Core/OtherAssets/sun2.png"),
	15: preload("res://OS_Core/OtherAssets/sun2.png"),
	16: preload("res://OS_Core/OtherAssets/sun3.png"),
	17: preload("res://OS_Core/OtherAssets/sun3.png"),
	18: preload("res://OS_Core/OtherAssets/sun4.png"),
	19: preload("res://OS_Core/OtherAssets/sun5.png"),
	20: preload("res://OS_Core/OtherAssets/sun6.png"),
	21: preload("res://OS_Core/OtherAssets/sun7.png"),
	22: preload("res://OS_Core/OtherAssets/sun8.png"),
	23: preload("res://OS_Core/OtherAssets/sun8.png"),	
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# TODO: Get rid of Save/Load and instead just have Score on the left and Sun icon on the right.
# Or possibly even the other way around to mess with the player's attention....

func show_taskbar():
	%TimeIcon.hide()
	%Title.hide()
	%Score.hide()
	show()
	await get_tree().create_timer(0.05).timeout
	%TimeIcon.show()
	await get_tree().create_timer(0.05).timeout
	%Title.show()
	await get_tree().create_timer(0.05).timeout
	# %Score.show()
	# await get_tree().create_timer(0.05).timeout

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

func _handle_time():
	var hour = GlobalVars.get_time()[0]
	%TimeIcon.texture = icon_dict[hour % 24]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_handle_score()
	_handle_time()
