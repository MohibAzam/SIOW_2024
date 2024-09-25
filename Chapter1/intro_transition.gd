extends Node2D
signal done_transition

var frame_counter = 0
var pos_mode = true
var emitted = false
var chkpt_1 = 100
var chkpt_2 = 200
var chkpt_3 = 225
var chkpt_4 = 280

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Begin on a black screen
	$Circle.hide()
	$Circle.position.x = int($Background.size.x / 2) - 150
	$Circle.position.y = int($Background.size.y / 2) - 150
	pass # Replace with function body.

func _flicker(frame_num) -> void:
	if frame_num == chkpt_2:
		$Circle.scale.x = 0.001
		$Circle.scale.y = 0.001
	elif frame_num == chkpt_1 or frame_num == (chkpt_2 - 1):
		$Circle.scale.x = 0.005
		$Circle.scale.y = 0.005
	elif frame_num == (chkpt_1 + 1) or frame_num == (chkpt_2 - 2):
		$Circle.scale.x = 0.01
		$Circle.scale.y = 0.01
	elif (frame_num % 6 == 0):
		$Circle.scale.x += (2 * int(pos_mode) - 1) * 0.01
		$Circle.scale.y += (2 * int(pos_mode) - 1) * 0.01
		if $Circle.scale.x <= 0.01 or $Circle.scale.x >= 0.05:
			pos_mode = not(pos_mode)

func _expand(frame_num) -> void:
	$Circle.scale.x = 1.15 * ($Circle.scale.x)
	$Circle.scale.y = 1.15 * ($Circle.scale.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	frame_counter += 1
	# Flicker at a small size for a little bit
	if frame_counter >= chkpt_1 and frame_counter <= chkpt_2:
		$Circle.show()
		_flicker(frame_counter - chkpt_1)	
	elif frame_counter >= chkpt_3 and frame_counter < chkpt_4:
		_expand(frame_counter - chkpt_3)
	elif frame_counter == chkpt_4:
		$Background.color = Color(1, 1, 1)
		remove_child($Circle)
	elif frame_counter > chkpt_4 and frame_counter % 10 == 9:
		$Background.color.r8 -= 1
		$Background.color.g8 -= 1
		$Background.color.b8 -= 1
	if $Background.color.r8 == 240:
		done_transition.emit()
	pass
