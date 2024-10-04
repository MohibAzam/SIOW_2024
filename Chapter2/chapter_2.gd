extends Node2D

var desktop
var desktop_load = preload("res://OS_Core/Desktop.tscn")

var _intro_text_done: bool = false

var _active_method = "" # This tells us which method is currently active (to prevent clashing)

var base_timer = 2

signal chapter_end

func _write_stuff_intro(text_entries, end_timer=base_timer, pause_timer=base_timer/2):
	for i in range(len(text_entries)):
		var text = text_entries[i][0]
		var speed = text_entries[i][1]
		if i > 0:
			await get_tree().create_timer(pause_timer).timeout
			desktop.write_text(text, speed, {'reset'=false})
		else:
			desktop.write_text(text, speed)
		await Signal(desktop, 'text_done')
	await get_tree().create_timer(end_timer).timeout


func _start_day() -> void:
	_write_stuff_intro([["Uaaaaaaaaaaaaa", 4], [" Yeah, looks like it's the morning now.", 4]])
	_write_stuff_intro([["...Damn, I really have no clue how to type out a yawn, huh.", 4]])
	_write_stuff_intro([["Oh well, a new day, a new me. I think I've adjusted myself to feel more like a normal person."], 4])
	_write_stuff_intro([["Eugh, I can't believe I was talking like a spambot yesterday. Just thinking about it is making me wince a bit...", 4]])
	_write_stuff_intro([["Oh well...what do I have in store for today."]])
	_write_stuff_intro([["I think the main thing I gotta do is start up a bunch of experiments."]])
	_write_stuff_intro([["Gordon wasn't really happy with the results yesterday...I remember seeing a note about "]])
	
func _on_spam_email_1() -> void: _write_stuff_intro([["Huh, an email.", 4], [" Let's check it out.", 4]])

func _on_sohail_email() -> void: 
		_active_method = "_on_spam_email_3"
		_write_stuff_intro([["Hnnngh...another email...", 4]])
		
		_write_stuff_intro([["Oh my GOD can I PLEASE stop getting these pings.", 4], [" I'm trying to do my work here.", 4]])
		
		_write_stuff_intro([["LEAVE ME ALOOOONE OH MY GOOOOOOOOOOOD."], 8])
		_write_stuff_intro([["I'm trying to my fucking work and I keep getting bombarbed with EMAILS."]])
	 
		_write_stuff_intro([["I swear, I should just turn off pings.", 4], [" This is so fucking stupid. What could POSSIBLY be so important??", 4]])

func _on_sohail_email_read() -> void:
	_active_method = "_on_spam_email_3"
	_write_stuff_intro([["Hnnngh...another email...", 4]])
		
	_write_stuff_intro([["Oh my GOD can I PLEASE stop getting these pings.", 4], [" I'm trying to do my work here.", 4]])
		
	_write_stuff_intro([["Oh you've gotta be fucking kidding me."], 2], [" What do you MEAN you need more data???"], 2)
	_write_stuff_intro([["This fucking guy...did he just FORGET his login or something?????", 2], [" How the fuck someone so incompetent managed to be Gordon's golden boy is beyond me."]])
	_write_stuff_intro([["I'm trying to my fucking work and I keep getting bombarbed with EMAILS."]])
	
	# Options for the email (the options available should differ depending on stress level)
	([["Dear Sohail,\n"]])
	([["To Sohail,\n"]])
	([["Sohail,\n"]])
	([["Hi Sohail,\n"]])
	([["Hey Sohail, \n"]])
	([["Dear Soho,\n"]])
	([["To Soho,\n"]])
	([["Soho,\n"]])
	([["Hi Soho,\n"]])
	([["Hey Soho, \n"]])
	
	"""
	([["Oh? Oh really? You REAAAAAAAAALLY want me to grab you more fucking data on a Friday afternoon???"]])
	([["Unfuckingbelieveable. Did you seriously just FORGET to set up your VPN before you left for NeurIPS?"]])
	([["Tough shit, please leave me alone."]])
	([["No."]])
	([["Ohhhhh my god shut the fuck up."]]) 
	([["I'm sorry to hear that! I hope you're holding up okay."]])
	([["Sure! I would be glad to help you out!"]])
	([["Sorry, I'm pretty busy right now, so I can't help, sorry!"]])
	([["I can help, but I don't know if I'll have much time"]])
	"""

	await _write_stuff_intro([["No...this won't work. I go?tta have more of a can-do attitude."]])
	_write_stuff_intro([["I swear, I should just turn off pings.", 4], [" This is so fucking stupid. What could POSSIBLY be so important??", 4]])


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
