extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AcceptRect.hide()
	await get_tree().create_timer(0.05).timeout
	$Label.show()
	await get_tree().create_timer(0.05).timeout
	$Label2.show()
	await get_tree().create_timer(0.05).timeout
	$Label3.show()

func accept_appear():
	$AcceptRect.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
