extends Panel

var subject = "" # Subject of the email
var sender = "" # Email's sender
var body = "" # Email's contents
var read_flag = false # Whether or not the email has been read
var replied_flag = false # Whether or not you've replied to the email
var mouse_on = false

signal spawn_email_entry(subject, sender, body, replied_flag)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _on_mouse_entered() -> void:
	mouse_on = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$HBoxContainer/Sender.text = sender
	$HBoxContainer/Subject.text = subject
	if read_flag:
		self.add_theme_color_override("bg_color", Color(0.75, 0.75, 0.75)) 
	if mouse_on and Input.is_action_just_pressed("MouseClick"):
		spawn_email_entry.emit(subject, sender, body, replied_flag)
		read_flag = true
		

func _on_mouse_exited() -> void:
	mouse_on = false
