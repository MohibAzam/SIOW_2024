extends PanelContainer

"""
Script to handle each individual Email within the Email App
"""

# TODO: Fix the alignment of this!

# Set up the contact of the email
func set_contact(contact):
	$HBoxContainer/Contact.text = contact

# Set up the subject of the email
func set_subject(subject):
	$HBoxContainer/Subject.text = subject
