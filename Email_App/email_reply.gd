extends MarginContainer

# Emit this once we're ready to start writing a message. It will also note 
# the largest number of options the textbox needs to handle 
signal deleting(text)
signal doing_something_w_attach
signal attaching
signal sending(text, selected_text, selected_buttons)
signal writing(text, button_ind)

# List of the buttons we've clicked on so far. It's handled like a stack, so
# if we delete a piece of the message we handle that accordingly.
var selected_buttons: Array = []
var selected_text: Array = []

var curr_message_text: String # This is the current text within the email
var curr_idx: int = 0 # Which piece of the message we're currently on.
var _active_options: Array # The options that are currently available for the player

var _typing: int = 0 # If positive, we're typing. Otherwise, we're deleting
var pending_text: String # The text that will be added to the message
var _pending_text_len: int # Length of the new text
var _pending_text_ind: int # Current position we're on for the new text

var _options_buffer = [] # Buffer for updating the options
var attachment: String = ""
var _attaching_open = false

# TODO: Add a delete button at the end of the options

# Once the player clicks a button, pass that button's index into the email so
# we can add text accordingly.
func _handle_chosen_button(option: String, button_ind: int) -> void:
	# Only allow this if we're not currently typing anything. 
	# If we get a bad index, just assume it's a delete operation.
	if not(_typing == 0):
		push_warning("The message is already being updated!")
	elif _attaching_open:
		attaching.emit()
	elif button_ind > len(_active_options):
		delete_text()
	else:
		pending_text = option
		_pending_text_ind = 0
		_pending_text_len = len(pending_text)
		_typing = 1

# Delete the most recently added text
func delete_text() -> void:
	# Don't do anything if we're at the start of the message of we're already
	# updating stuff
	if curr_idx == 0:
		push_warning("Attempting to delete message when no message is active")
	elif not(_typing == 0):
		push_warning("The message is already being updated!")
	elif _attaching_open:
		attaching.emit()
	else:
		_pending_text_ind = 0
		_pending_text_len = len(pending_text)
		_typing = -1

func _update_char(add_flag) -> void:
	# Add or delete a character to the text, depending on the value
	if add_flag:
		curr_message_text += pending_text[_pending_text_ind]
	else:
		curr_message_text = curr_message_text.erase(len(curr_message_text) - 1)
	_pending_text_ind += 1
	
	# If we've reached the end of the text, handle that accordingly
	if _pending_text_ind >= _pending_text_len:
		_typing = 0
		_pending_text_ind = 0
		curr_idx += 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body. 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not (_typing == 0):
		_update_char(_typing > 0)
	if len(_options_buffer) > 0 and _typing == 0:
		%EmailOptions.set_options(_options_buffer)
		_options_buffer = []

func _on_send_pressed() -> void: sending.emit(curr_message_text, selected_text, selected_buttons)

func update_options(options) -> void: _options_buffer = options
	
func _on_attach_pressed() -> void:
	attaching.emit()
	_attaching_open = true

func attaching_closed(given_attachment = "") -> void:
	attachment = given_attachment
	_attaching_open = false

func _on_option_exited(option: Variant) -> void:
	if pending_text == option:
		pending_text = ""

func _on_option_hovered(option: Variant) -> void: pending_text = option

func _on_option_selected(option: Variant, ind) -> void:
	writing.emit(option, ind)
	%EmailOptions.clear_options()
	_handle_chosen_button(option, ind)
