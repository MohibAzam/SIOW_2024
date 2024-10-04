extends Window

"""
Script to handle the main Email application (with all the emails)
"""

# TODO: Change this to a scroller instead?

var curr_page_index = 0 # The current page of emails we're on
var max_page = 0 # The final page of the emails
var _entry_num = 6 # The number of entries per page (reduces hardcoding)

# Emit this when we're viewing the contents of an email
signal spawn_email_entry(subject, sender, body, replied_flag, read_flag) 

# Emit with when we're closing the app
signal closing_app(app_name: String)

func _handle_spawn_email_attempt(subject, sender, body, replied_flag, read_flag):
	spawn_email_entry.emit(subject, sender, body, replied_flag, read_flag)

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
	_current_emails()
	_update_arrows()

# Close the app when requested
func _on_close_requested() -> void: closing_app.emit(self.name)


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalVars.emails_updated.connect(_handle_emails_updated)
	_current_emails()
	_update_arrows()


func _process(float) -> void: pass
