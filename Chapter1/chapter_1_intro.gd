extends Node2D

var terminal

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var terminal_load = load("res://OS/AITerminal.tscn")
	terminal = terminal_load.instantiate()
	add_child(terminal)
	terminal.position.x = 500
	terminal.position.y = -25
	await Signal(terminal, 'ready_for_use')
	await get_tree().create_timer(2).timeout
	terminal.write_text("..................", 16)
	await Signal(terminal, 'text_done')
	await get_tree().create_timer(2).timeout
	terminal.write_text("...................?", 16)
	await Signal(terminal, 'text_done')
	await get_tree().create_timer(2).timeout
	terminal.write_text("...What.......?", 8)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
