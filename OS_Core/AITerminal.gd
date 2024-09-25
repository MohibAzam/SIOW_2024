extends Node2D

var buffered_text = ""
var curr_text = ""
var curr_text_ind = 0
var _write_mode = false
var default_write_timer = 2
var write_speed_dict = {}
var curr_delta = 0

signal text_done
signal grown
signal ready_for_use

func write_text(given_text, base_timer=2, specific_timers={}, textbox_ind=0, font_size=0):
	buffered_text = given_text
	default_write_timer = base_timer
	for i in range(len(given_text)):
		if i in specific_timers:
			write_speed_dict[i] = specific_timers[i]
		else:
			write_speed_dict[i] = base_timer
	curr_text = ""
	_write_mode = true
	curr_delta = 0
	curr_text_ind = 0
	if font_size > 0:
		$VBox/Text.set("theme_override_font_sizes/font_size", font_size)

func _grow_out() -> void:
	$HBoxContainer2.scale.x = 0
	$HBoxContainer2.scale.y = 0
	var grow_counter = 0
	while $HBoxContainer2.scale.x < 1:
		$HBoxContainer2.scale.x += 0.05
		$HBoxContainer2.scale.y += 0.05
		await get_tree().create_timer(0.015).timeout 
	grown.emit()

# Called when the node enters the scene tree for the first time.
func _ready():
	_grow_out()
	await grown
	ready_for_use.emit()
	_write_mode = false
	# write_text("This is some more sample text, but slower", 4)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _write_mode:
		curr_delta += 1
		if curr_delta >= write_speed_dict[curr_text_ind]:
			curr_text += buffered_text[curr_text_ind]
			curr_text_ind += 1
			curr_delta = 0 
		if curr_text == buffered_text:
			_write_mode = false
			text_done.emit()
	$HBoxContainer2/TextPanel/MainText.text = curr_text
