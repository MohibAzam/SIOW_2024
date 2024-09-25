extends Button

signal clicked_name(option)
signal hovered_name(option)
signal exited_name(option)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pressed.connect(_give_name)
	self.mouse_entered.connect(_handle_enter_hover)
	self.mouse_entered.connect(_handle_exit_hover)
	
# Emit an appropriate signal when we hover, dehover, or click the button
func _handle_enter_hover() -> void: hovered_name.emit(self.text)
func _handle_exit_hover() -> void: exited_name.emit(self.text)
func _give_name() -> void: clicked_name.emit(self.text)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
