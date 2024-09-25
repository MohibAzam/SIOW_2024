extends Window

var subject = "" # Subject of the email
var sender = "" # Email's sender
var body = "" # Email's contents
var replied_flag = false # Whether or not you've replied to the email
var _latest_flag = false # Used to keep track of the replied flag being changed

signal spawn_reply(subject, sender, body, replied_flag)
signal closing_app(app_name)

func _render_updates() -> void:
	%Subject.text = subject
	%Sender.text = sender
	%Body.text = body
	if replied_flag and not _latest_flag:
		%Reply.hide()
		%Replied.show()
		_latest_flag = true
	elif _latest_flag:
		%Reply.show()
		%Replied.hide()
		_latest_flag = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void: pass

# Called every frame. 'delta' is the elapsed time since the previous frame.  
func _process(delta: float) -> void: _render_updates()

# Send out the closing signal when a close request is made
func _on_close_requested() -> void: closing_app.emit(self.name)

# Send out a reply signal when the reply button is pressed
func _on_reply_button_pressed() -> void: spawn_reply.emit(subject, sender, body, replied_flag)
