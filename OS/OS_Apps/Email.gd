extends Panel

"""
Script to handle the Email application 
"""


# TODO: Why is scroll container not working?
# TODO: Why is the window stretching not working? (We want to do it dynamically,
# and not have to hard code it...)

# Called when the node enters the scene tree for the first time.
func _ready():
	# Add some sample emails as a little test!
	var path = preload("res://OS/OS_Apps/EmailEntry.tscn")
	var email_entry1 = path.instantiate()
	email_entry1.set_contact("Foo")
	email_entry1.set_subject("This is a test email!")
	$VBoxContainer/EmailList.add_child(email_entry1)
	
	var email_entry2 = path.instantiate()
	email_entry2.set_contact("Bar")
	email_entry2.set_subject("This is also a test email!")
	$VBoxContainer/EmailList.add_child(email_entry2)

