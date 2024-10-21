extends PanelContainer

var entry_template = preload('res://ToDo_App/TodoEntry.tscn')
var _task_mark_dict = {}
var _task_names_dict = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grow_out()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void: pass

func add_task(task_name):
	var entry_node = entry_template.instantiate()
	entry_node.set_item(task_name)
	_task_mark_dict[task_name] = false
	_task_names_dict = entry_node.name
	%Vbox.add_child(entry_node)

func mark_done(task_node):
	var node_name = _task_names_dict[task_node]
	%Vbox.get_node(node_name).mark_done()
	_task_mark_dict[task_node] = true
	
func mark_undone(task_node):
	var node_name = _task_names_dict[task_node]
	%Vbox.get_node(node_name).mark_undone()
	_task_mark_dict[task_node] = false
	
func grow_out():
	$MarginContainer.hide()
	scale.x = 0.7
	scale.y = 0.7
	var grow_counter = 0
	while scale.x < 1:
		scale.x += 0.05
		scale.y += 0.05
		await get_tree().create_timer(0.015).timeout 
	%Title.hide()
	%ScrollContainer.hide()
	$MarginContainer.show()
	%Title.show()
	await get_tree().create_timer(0.05).timeout 
	%ScrollContainer.show()
	await get_tree().create_timer(0.05).timeout 
	
func change_title(title): %Title.text = title

func get_task_status(): return _task_mark_dict
