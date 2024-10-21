extends Node2D

var _email_stack = []

var _ana_messages = []
var _zhenhuang_messages = []

var _curr_hour = 8
var _curr_minute = 0
var curr_month = 11
var curr_day = 15
var _score = 0

var stored_files = {}

signal emails_updated
signal time_updated(hour, min)
signal score_updated(score)

var current_options = {}

func _load_email_option_csvs():
	pass

func increment_time(min) -> void:
	assert(min >= 0)
	_curr_minute += min
	if _curr_minute >= 60:
		_curr_hour += floor(_curr_minute / 60)
		_curr_minute = (_curr_minute % 60)
	time_updated.emit(_curr_hour, _curr_minute)
	
func get_time(): return [_curr_hour, _curr_minute]
func get_date(): return [curr_month, curr_day]

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

func push_ana_message(message, from_us=false): _ana_messages.append({'message': message, 'from_us':from_us})
func push_zhen_message(message, from_us=false): _zhenhuang_messages.append({'message': message, 'from_us':from_us})

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_load_email_option_csvs()
	var sample_email_1 = {}
	sample_email_1['subject'] = "This is a test email!"
	sample_email_1['sender'] = "John Doe"
	sample_email_1['body'] = "To Veronica,\n\nThis is your left ear.\nLe-le-le-left!\n\n Best,\nJohn"
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func push_initial_emails():
	print("pushing")
	# var email_0 = {}
	# email_0['sender'] = ''	

	var email_1 = {}
	email_1['sender'] = "Anna Fan"
	email_1['subject'] = "Hi!!! Wanna catch up?"
	email_1['body'] = "Hey there, this is Anna! My life was pretty hectic these past few years," + \
		"but I've managed to settle down a little bit and am doing pretty good now!" + \
		"What about you? I hear you're a PhD student, so I imagine you're doing pretty" + \
		"well for yourself lol.\n\nIf you're up for it, let's chat some time on Blabber!" + \
		"My account is just my full name, feel free to add me and we can talk some time n_n\n\n- Anna"
					
	
	var email_2 = {}
	email_2['sender'] = "Gordon Jarrett"
	email_2['subject'] = "Updates"
	email_2['body'] = "Veronica,\n\n" + \
		"I am unfortunately busy with NeurIPS this week, so we'll have to skip our weekly meeting." + \
		"Please send me any updates you have by the end of the week and I will go over them as best" + \
		"as I can; please keep in mind the NAACL deadline is in about a month.\n\nBest,\nGordon" 


	var email_3 = {}
	email_3['sender'] = "Sohail Ahmad"
	email_3['subject'] = "Urgent help needed with data"
	email_3['body'] = "Hey Veronica,\n\nThis is a bit embarrassing to say, but I desperately need your help.\n\n" + \
		"I need to edit my workshop slides but I'm missing one of the results tables that I got last week." + \
		"I can't SSH from the lab server, so I can't pull the data from here. The data I need is the <TODO>." + \
		"Could you please pull the data and send it over? My workshop is on Saturday," + \
		"so I need it as soon as possible.\n\nThanks,\nSohah"

	var email_4 = {}
	email_4['sender'] = "QU West ResLife"
	email_4['subject'] = "Reminders for Thanksgiving!"
	email_4['body'] = "Hello everyone!\n\n" + \
		"For those of you planning on leaving for Thanksgiving break, here are some reminders that you need to be keeping in mind:\n\nHave a Happy Holidays!\nWest ResLife\n\n(THIS IS AN AUTOMATED EMAIL)"
	
	GlobalVars.add_email_stack(email_4)
	GlobalVars.add_email_stack(email_2)
	GlobalVars.add_email_stack(email_1)
	GlobalVars.add_email_stack(email_3)
