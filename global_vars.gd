extends Node2D

var _email_stack = []

var _ana_messages = []
var _zhenhuang_messages = []

var _curr_hour = 8
var _curr_minute = 0
var _score = 0

var stored_files = {}

signal emails_updated
signal time_updated(hour, min)
signal score_updated(score)

func increment_time(min) -> void:
	assert(min >= 0)
	_curr_minute += min
	if _curr_minute >= 60:
		_curr_hour += floor(_curr_minute / 60)
		_curr_minute = (_curr_minute % 60)
	time_updated.emit(_curr_hour, _curr_minute)
	
func get_time(): return [_curr_hour, _curr_minute]

func set_score(new_score) -> void:
	_score = new_score
	score_updated.emit(_score)

func increment_score(increment_val) -> void:
	_score += increment_val
	score_updated.emit(_score)
	
func get_score():
	return _score

func get_email_stack():
	return _email_stack
	
func add_email_stack(entry: Dictionary):
	if not entry.has('read'):
		entry['read'] = false
	if not entry.has('replied'):
		entry['replied'] = false
	_email_stack.push_front(entry)
	emails_updated.emit()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var sample_email_1 = {}
	sample_email_1['subject'] = "This is a test email!"
	sample_email_1['sender'] = "John Doe"
	sample_email_1['body'] = "To Veronica,\n\nThis is your left ear.\nLe-le-le-left!\n\n Best,\nJohn"
	add_email_stack(sample_email_1)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
