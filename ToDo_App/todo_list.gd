extends PanelContainer

var entry_template = preload('res://ToDo_App/TodoEntry.tscn')
var _task_mark_dict = {}
var _task_names_dict = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
	
func change_title(title): %Title.text = title

func get_task_status(): return _task_mark_dict
