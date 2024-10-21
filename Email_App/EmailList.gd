extends MarginContainer

"""
Script to handle the main Email application (with all the emails)
"""

# TODO: Change this to a scroller instead?

var curr_page_index = 0 # The current page of emails we're on
var max_page = 0 # The final page of the emails
var _entry_num = 6 # The number of entries per page (reduces hardcoding)

var email_node_template = preload('res://Email_App/Email Entry.tscn')

# Emit this when we're viewing the contents of an email
signal spawn_email_entry(subject, sender, body, replied_flag, read_flag) 

func _handle_spawn_email_attempt(subject, sender, body, replied_flag, read_flag):
	print("spawning...")
	spawn_email_entry.emit(subject, sender, body, replied_flag, read_flag)

"""
func _current_emails():
	var _email_entries = GlobalVars.get_email_stack()
	max_page = ceil(len(_email_entries) / _entry_num) - 1
	var email_subset = []
	var start_ind = curr_page_index * _entry_num
	if len(_email_entries) > (start_ind + _entry_num):
		email_subset = _email_entries.slice(start_ind, (start_ind + _entry_num))
	else:
		email_subset = _email_entries.slice(start_ind)
	for i in range(_entry_num):
		var target_entry = get_node("VBoxContainer/EmailEntry" + str(i))
		if i >= len(email_subset):
			target_entry.hide()
		else:
			var email_data = email_subset[i]
			target_entry.subject = email_data["subject"]
			target_entry.sender = email_data["sender"]
			target_entry.body = email_data["body"]
			target_entry.replied_flag = email_data["replied"]
			target_entry.read_flag = email_data["read"]
			target_entry.show()
"""

func _update_data(old_entry, new_entry):
	old_entry.subject = new_entry["subject"]
	old_entry.sender = new_entry["sender"]
	old_entry.body = new_entry["body"]
	old_entry.replied_flag = new_entry["replied"]
	old_entry.read_flag = new_entry["read"]

func _current_emails():
	print("~~Updating Emails~~")
	var _email_entries = GlobalVars.get_email_stack()
	var children = %ListVBox.get_children()
	var skip_check = false
	var top_child
	if not children: skip_check = true
	else: top_child = children[0]
	var top_found = false 
	var start_ind = 0
	for i in range(len(_email_entries)):
		var email_data = _email_entries[i]
		if skip_check: pass
		elif top_found or email_data["subject"] == top_child["subject"]:
			top_found = true
			start_ind = i
			break
		var new_entry = email_node_template.instantiate()
		_update_data(new_entry, _email_entries[i])
		new_entry.spawn_email_entry.connect(_handle_spawn_email_attempt)
		%ListVBox.add_child(new_entry)
		print("new child")
		%ListVBox.move_child(new_entry, i)
		
			
	for j in range(len(children)):
		var new_data = _email_entries[start_ind + j]
		var old_entry = children[j]
		_update_data(old_entry, new_data)

func _handle_emails_updated(): _current_emails()

func _update_arrows():
	if curr_page_index == 0:
		$VBoxContainer/HBoxContainer/LeftPage.disabled = true
	else:
		$VBoxContainer/HBoxContainer/LeftPage.disabled = false
	if curr_page_index >= max_page:
		$VBoxContainer/HBoxContainer/RightPage.disabled = true
	else:
		$VBoxContainer/HBoxContainer/RightPage.disabled = false

func _on_left_page_pressed() -> void:
	curr_page_index = max(0, curr_page_index - 1)
	print(curr_page_index)
	_current_emails()
	_update_arrows()

func _on_right_page_pressed() -> void:
	curr_page_index = min(max_page, curr_page_index + 1)
	print(curr_page_index)
	_update_arrows()
	_current_emails()

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalVars.emails_updated.connect(_handle_emails_updated)
	# _push_initial_emails()
	_current_emails()
	_update_arrows()


func _process(float) -> void: pass
