extends Control
signal closing_app(app_name)

var _adjust_size = 0
var max_x = custom_minimum_size.x
var max_y = custom_minimum_size.y
var adjust_counter = 0

# Called when the node enters the scene tree for the first time.
# TODO: See if you can give a fade-in animation for the window? 
# A growing animation isn't feasible it seems...

func _ready() -> void: _grow_out()

func add_app(new_app) -> void: %Contents.add_child(new_app)

func show_app() -> void:
	# for child in %Contents.get_children(): child.hide()
	show()
	# _adjust_size = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	"""
	adjust_counter += 1
	if adjust_counter % 1 == 0:
		if not(_adjust_size == 0) and custom_minimum_size.x < max_x:
			custom_minimum_size.x += _adjust_size
			custom_minimum_size.y += _adjust_size
			if custom_minimum_size.x == max_x:
				if _adjust_size > 0: _done_grow()
				else: _done_shrink()
				_adjust_size = 0
	"""

func set_title(title: String) -> void: %Title.text = title

func update_size(x, y):
	%Contents.custom_minimum_size = Vector2(x, y)
	custom_minimum_size = Vector2(x, y)
	_done_grow()

func _on_texture_button_pressed() -> void:
	# Perform the closing animation
	# $MarginContainer.hide()
	# max_x = custom_minimum_size.x - 50
	# max_y = custom_minimum_size.x - 50
	# _adjust_size = -1
	# for child in %Contents.get_children(): child.hide()
	await _shrink_down()
	hide()
	closing_app.emit(self.name)
	
func _grow_out() -> void:
	for child in %Contents.get_children(): child.hide()
	$MarginContainer.hide()
	scale.x = 0.7
	scale.y = 0.7
	var grow_counter = 0
	while scale.x < 1:
		scale.x += 0.05
		scale.y += 0.05
		await get_tree().create_timer(0.015).timeout 
	for child in %Contents.get_children(): child.show()
	$MarginContainer.show()

func _shrink_down() -> void:
	for child in %Contents.get_children(): child.hide()
	$MarginContainer.hide()
	var grow_counter = 0
	while scale.x > 0.7:
		scale.x -= 0.05
		scale.y -= 0.05
		await get_tree().create_timer(0.015).timeout 

func _done_grow() -> void:
	var title_len = %Title.size.x
	var center_point = %Contents.custom_minimum_size.x / 2
	var start_point = center_point - title_len/2
	%VSeparator.custom_minimum_size.x = start_point - 32
	for child in %Contents.get_children(): child.show()
	%HBox.show()
	$Contents.show()
	print(size)
	print(%Contents.size)

func _done_shrink() -> void:
	hide()
	closing_app.emit()
