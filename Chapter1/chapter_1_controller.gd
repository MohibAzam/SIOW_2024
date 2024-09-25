extends Control

"""
This is a controller that messes with the desktop to allow the player to experience Chapter 1
"""
# TODO: Some stuff to consider
# - Add the ability to disable certain clickable options 
# - Add canvas layers above certain elements to create the anxiety effects
# - Handle the flow for options in emails  

signal done_message # Emit this once we've finished 

# NOTE: A lot of code here is just scraps that we didn't need (but will likely need
# later) from email_reply.gd
_active_options[button_ind]

# Call this whenever we have to update the options for the player to choose from
func _update_options() -> String:
	var idx_data: Dictionary = loaded_text_info['Pieces'][curr_idx]
	_active_options = idx_data['Options']
	return idx_data['ThoughtText']
	if curr_idx >= len(loaded_text_info):
			done_message.emit(loaded_text_info["DoneMessage"])
		else:
			_update_options()
			done_portion.emit(loaded_text_info[""])

			
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
