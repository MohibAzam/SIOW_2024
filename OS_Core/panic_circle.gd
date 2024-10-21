extends Panel

# How frequently we update the color of the image
var flicker_time = 1

# The counter and direction by which we update the circle
var flicker_up = true
var kirby = 112

var move_freq = 15
var move_counter = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_counter += 1
	if flicker_up:
		kirby += 2
	else:
		kirby -= 2
	var new_color = Color()
	new_color.r8 = 192	
	new_color.g8 = 192
	new_color.b8 = kirby
	new_color.a8 = 220
	var new_style = get("theme_override_styles/panel")
	new_style.set_bg_color(new_color)
	set("theme_override_color/bg_color", new_style)
	if kirby >= 128:
		flicker_up = false
	if kirby <= 32:
		flicker_up = true
	if move_counter % move_freq == 0:
		position.x += randi_range(-1, 1)
		position.y += randi_range(-1, 1)
	
	var curr_size = self.size.x
	if curr_size >= 75:
		curr_size =- 1
	elif curr_size <= 70:
		curr_size += 1
	update_size(curr_size)

func update_size(new_size: int) -> void:
	self.size.x = new_size
	self.size.y = new_size


	# while 
	# TODO: Panic minigame: Floating thought bubbles appear, your goal is to 
	# pick some to attempt to temporarily reduce your anxiety. You will still
	# have some negative thoughts upon doing so, but you will be able to work
	# to some degree
