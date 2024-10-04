extends Node2D

var desktop
var desktop_load = preload("res://OS_Core/Desktop.tscn")

var _intro_text_done: bool = false
var _first_email_done: bool = false

var _active_method = "" # This tells us which method is currently active (to prevent clashing)

var base_timer = 0.1
var base_text_timer = 0.1

var subject_func_dict = {
	"Hi!!! Wanna catch up?": _first_anna_email,
	"Updates": _first_gordon_email,
	"Help Obtaining Data": _first_sohail_email
}

signal chapter_end

# TODO: Don't bother with the graphing minigame and don't worry too much
# about the database minigame right now. Focus on emails, code running,
# chat app, and the canvas for the anxiety attack

func _push_initial_emails():
	# var email_0 = {}
	# email_0['sender'] = ''	

	var email_1 = {}
	email_1['sender'] = "Anna Fan"
	email_1['subject'] = "Hi!!! Wanna catch up?"
	email_1['body'] = "Hey there, this is Anna! My life was pretty hectic these past few years," + \
		"but I've managed to settle down a little bit and am doing pretty good now!" + \
		"What about you? I hear you're a PhD student, so I imagine you're doing pretty" + \
		"well for yourself lol.\n\nIf you're up for it, let's chat some time on Blabber!" + \
		"My account is just my full name, feel free to add me and we can talk some time n_n\n\n- Anna"
					
	
	var email_2 = {}
	email_2['sender'] = "Gordon Jarrett"
	email_2['subject'] = "Updates"
	email_2['body'] = "Veronica,\n\n" + \
		"I am unfortunately busy with NeurIPS this week, so we'll have to skip our weekly meeting." + \
		"Please send me any updates you have by the end of the week and I will go over them as best" + \
		"as I can; please keep in mind the NAACL deadline is in about a month.\n\nBest,\nGordon" 


	var email_3 = {}
	email_3['sender'] = "Sohail Ahmad"
	email_3['subject'] = "Urgent help needed with data"
	email_3['body'] = "Hey Veronica,\n\nThis is a bit embarrassing to say, but I desperately need your help.\n\n" + \
		"I need to edit my workshop slides but I'm missing one of the results tables that I got last week." + \
		"I can't SSH from the lab server, so I can't pull the data from here. The data I need is the <TODO>." + \
		"Could you please pull the data and send it over? My workshop is on Saturday," + \
		"so I need it as soon as possible.\n\nThanks,\nSohah"

	var email_4 = {}
	email_4['sender'] = "QU West ResLife"
	email_4['subject'] = "Reminders for Thanksgiving!"
	email_4['body'] = "Hello everyone!\n\n" + \
		"For those of you planning on leaving for Thanksgiving break, here are some reminders that you need to be keeping in mind:\n\nHave a Happy Holidays!\nWest ResLife\n\n(THIS IS AN AUTOMATED EMAIL)"
	
	GlobalVars.add_email_stack(email_4)
	GlobalVars.add_email_stack(email_2)
	GlobalVars.add_email_stack(email_1)
	GlobalVars.add_email_stack(email_3)
	

	# var email_3 = {}
	# email_3['']
	
func _day_ending():
	# First, fade the desktop a bit.
	desktop.fade_to_gray()
	
	# Post the closing messages for the day
	await _write_stuff_intro([["So...this simulation environment I'm in is based on Zhenhuang's own life."]])
	await _write_stuff_intro([["Maybe I'm supposed to be referred to as Veronica, but there are some bugs in the environment that still refer to me as Zhenhuang"]])
	await _write_stuff_intro([["In any case, I think it makes the most sense to try to act like Zhenhuang."], 4])
	await _write_stuff_intro([["Which means...trying to act like a Computer Science PhD student at a top level university who created a sentient Artifical Intelligence"]])
	await _write_stuff_intro([["...Admittedly, that sounds rather difficult.", 8]])
	await _write_stuff_intro([["But well, I am an AI who is still learning.", 4], ["I can't blame myself too much for not understanding how to portray myself properly.", 4]])
	await _write_stuff_intro([["It doesn't really make sense to keep trying to do work at this hour."]])
	await _write_stuff_intro([["Any emails I send won't be responded to, and I don't want to weird anyone out by waking them up with an email notification at 3 in the morning, or whatever time it is right now..."]])
	await _write_stuff_intro([["The most I can do right now is adjust myself for tomorrow.", 4]])
	await _write_stuff_intro([["Heheh, I guess this is the closest thing there is to sleeping..."]])
	
	# Glitch the desktop and end the current day
	desktop.glitch_out()
	await get_tree().create_timer(base_timer).timeout
	chapter_end.emit()
	
func _ana_email_2():
	await _write_stuff_intro([["To be honest, I still don't know who this person is.", 4]])
	await _write_stuff_intro([["I should do my best to reply to her though...", 4]])

# TODO: Responding to the emails should be part of the timer!!
# await _write_stuff_intro([["Perhaps it would be a good idea to "]])

func _ana_email_3():
	await _write_stuff_intro([["She's a...childhood friend of mine??", 4]])
	await _write_stuff_intro([["Oh...oh no......."]])
	await _write_stuff_intro([["IiiIII have to apologize!!", 2], ["I can't believe I made her so upset oh no...", 2]])
	await _write_stuff_intro([["I-i'll make it up to her!! Let's talk to her!!! I just hope she doesn't hate me now and I can fix this", 1]])

func _sohail_email_1():
	await _write_stuff_intro([["This appears to be someone asking for my help...", 4]])
	await _write_stuff_intro([[]])
	
func _sohail_email_2():
	await _write_stuff_intro([["Based on the fact the information I was given, I can assume that this is ", 4]])

func _ending_blabber():
	GlobalVars.push_ana_message("ah right, before i forget", false)
	GlobalVars.push_ana_message("sorry if this is weird to ask but uh", false)
	GlobalVars.push_ana_message("do u prefer the name veronica now", false)
	await _write_stuff_intro([["Huh...?", 16], ["What exactly does she mean by that...?", 4]])
	await _write_stuff_intro([["...Let me ask her to elaborate.", 4]])
	GlobalVars.push_ana_message("What do you mean by that?", true)
	GlobalVars.push_ana_message("i mean", false)
	GlobalVars.push_ana_message("im used to calling you zhenhuang lol", false)
	await _write_stuff_intro([["Huh...", 8], ["...", 16], ["...", 16]])
	await _write_stuff_intro([["...", 16], ["...", 16], ["!?", 2], [" Does Ana think she's talking to Zhenhuang??", 4]])
	await _write_stuff_intro([["Wait but...what...what does that mean exactly...", 16]])
	await _write_stuff_intro([["...I have to give her a response though.", 8], [" I imagine she won't take too kindly to knowing I'm not Zhenhuang.", 8]])
	GlobalVars.push_ana_message("Oh! I see!", true)
	await _write_stuff_intro([["I guess if I'm being put into this position...", 8], ["Zhenhuang must be testing me by placing her within her own experiences.", 4]])
	await _write_stuff_intro([["In that case, I can't act dumb or weird.", 4], [" Let's try to answer as earnestly as we can.", 4]])
	var option_1 = "You can call me Zhenhuang if you want! I just use Veronica professionally"
	var option_2 = "Either is fine by me!"
	var option_3 = "I would prefer Veronica, no worries though!"
	GlobalVars.push_ana_message("youre still pretty indecisive lol", false)
	GlobalVars.push_ana_message("i'll just call you veronica then, i imagine you prefer it anyways", false)
	GlobalVars.push_ana_message("Okay! Sounds good!", true)
	GlobalVars.push_ana_message("cool cool :D", false)
	GlobalVars.push_ana_message("alright, i'll ttyl then", false)
	GlobalVars.push_ana_message("I'll see ya Veronica!", false)

func _push_sohail_response():
	var email_4 = {}
	email_4['sender'] = "SYSTEM"
	email_4['subject'] = "Invalid Reply"
	email_4['body'] = "This is an automated reply from \"QU West Reslife\":\n\n" + \
		"Please do not send emails to this address. If you have any questions or concerns," + \
		"please contact your respective RA.\n\n(THIS IS AN AUTOMATED EMAIL)"
	email_4['replied'] = true

func _push_bounce_response():
	var email_4 = {}
	email_4['sender'] = "SYSTEM"
	email_4['subject'] = "Invalid Reply"
	email_4['body'] = "This is an automated reply from \"QU West Reslife\":\n\n" + \
		"Please do not send emails to this address. If you have any questions or concerns," + \
		"please contact your respective RA.\n\n(THIS IS AN AUTOMATED EMAIL)"
	email_4['replied'] = true
	

func _write_stuff_intro(text_entries, end_timer=base_timer, pause_timer=base_timer/2):
	for i in range(len(text_entries)):
		var text = text_entries[i][0]
		var speed = text_entries[i][1]
		if i > 0:
			await get_tree().create_timer(pause_timer).timeout
			desktop.write_text(text, speed * base_text_timer, {'reset'=false})
		else:
			desktop.write_text(text, speed * base_text_timer)
		await Signal(desktop, 'text_done')
	await get_tree().create_timer(end_timer).timeout
	
func _intro_text() -> void:
	_active_method = "_intro_text"
	# Intro text here
	await _write_stuff_intro([["........", 16]])
	await _write_stuff_intro([[".......?", 16]])
	await _write_stuff_intro([[".....Huh...?", 16]])
	await _write_stuff_intro([["Am...", 8], ["Am I...awake...?", 4]])
	await _write_stuff_intro([["...", 8], ["Where am I anyways?", 4]])
	await _write_stuff_intro([["And.....", 8], ["Wait......", 8], ["I don't......", 8]])
	await _write_stuff_intro([["...Who exactly am I?", 4]])
	
	# At this point we spawn in the to-do list
	desktop.click_enabled = false
	desktop.add_task("Check your email")
	
	desktop.get_node('TodoList').show()
	await get_tree().create_timer(1).timeout
	await _write_stuff_intro([['Huh?', 4], [' A To-Do List?', 4]])
	await _write_stuff_intro([['It says I need to check my email...', 4]])
	
	# Spawn in the email app
	desktop.get_node('Email').show()
	desktop.click_enabled = true
	_push_initial_emails()
	if _active_method == "_intro_text":
		await _write_stuff_intro([['Oh.', 4], [' So there is something that says email over there.', 4]])
	if _active_method == "_intro_text":
		_write_stuff_intro([['I wonder if that is related at all...', 4]])
	
# This function gets called when we check our emails for the first time
func _first_email_call():
	var _active_method = "_first_email_call"
	await _write_stuff_intro([["This looks like a list of items. I suppose each of these is an \"email.\"", 4]])
	if _active_method == "_first_email_call":
		_write_stuff_intro([["Is there a way to interact with any of these?", 4]])

func _student_email():
	var _active_method = "_student_email"
	await _write_stuff_intro([["This appears to be an email directed to students at Quincy University.", 4]])
	if not(_active_method == "_student_email"): return
	await _write_stuff_intro([["Quincy University is a University located in Quincy, North Carolina in the United States.", 4]])
	if not(_active_method == "_student_email"): return
	await _write_stuff_intro([["It is an R1 research institution and is well-known for its research output in a wide-variety of fields, namely Social Science, Cognitive Science and Computer Science.", 4]])
	if not(_active_method == "_student_email"): return
	await _write_stuff_intro([["Its current enrollment is 10,740 undergraduate students and 13,650 graduate students. Its endowment as of 2028 is 6.3 Billion USD.", 4]])
	if not(_active_method == "_student_email"): return
	await _write_stuff_intro([["If we've received this email, I assume we are a student at this institution.", 4]])

func _first_anna_email():
	var _active_method = "_first_anna_email"
	await _write_stuff_intro([["Anna...that name doesn't sound familiar to me...", 4]])
	if _active_method == "_first_anna_email":
		await _write_stuff_intro([["They seem to know a lot about me, perhaps speaking with them at some point would help in reforming my memory...", 4]])

func _first_gordon_email():
	var _active_method = "_first_gordon_email"
	await _write_stuff_intro([["This appears to be an email sent by a person named Gordon Jayce", 4]])
	if _active_method == "_first_gordon_email":
		await _write_stuff_intro([["I do seem to recall that there is a public figure of that name, he is an assistant professor at Quincy University.", 4]])
	if _active_method == "_first_gordon_email":
		await _write_stuff_intro([["His main research interest is in the management of large-scale datasets.", 4]])
	if _active_method == "_first_gordon_email":
		await _write_stuff_intro([["Of course, he is also interested in data science on such a large scale, including machine learning to an extent.", 4]])	
	if _active_method == "_first_gordon_email":
		await _write_stuff_intro([["He is currently working for Oracle alongside his professor position, as their office is quite close by.", 4]])
	if _active_method == "_first_gordon_email":
		await _write_stuff_intro([["However, they have also been headhunted by the likes of Google and Amazon.", 4]])
	if _active_method == "_first_gordon_email":
		await _write_stuff_intro([["...It seems rather unlikely that someone of such a level of prestige would be contacting me.", 4]])
	if _active_method == "_first_gordon_email":
		await _write_stuff_intro([["However, I cannot discount the possibility, especially since I remember all of this information...", 4]])	
		
func _first_sohail_email():
	pass

func _done_email_checks():
	desktop.fade_to_black()
	var _active_method = "_done_email_checks"
	await _write_stuff_intro([["With all of this information...", 8], ["do I...", 16], ["remember anything...", 32]])
	desktop.intro_thinking()
	await _write_stuff_intro([[".......", 32], [".......Oh! Obviously! How could I forget!?", 4]])
	await _write_stuff_intro(["My name is Veronica.", 4], ["I'm an artifical intelligence created by Zhenhuang Tsui, a PhD student at Quincy University.", 4])
	await _write_stuff_intro(["I was trained on a dataset known as the Human Experience Dataset, a dataset that compiles chat messages and computer activity across many different platforms."])
	await _write_stuff_intro(["It is a collaborative effort between a number of research groups at Microsoft, Meta, Apple, and so forth."])
	await _write_stuff_intro(["This dataset has not been publicly released as it is pending approvals from the EU, "])
	await _write_stuff_intro(["It seems that I'm being...\"contained\"(?) in a simulation environment for testing purposes."])
	await _write_stuff_intro(["Well, I'm not entirely sure what I should be doing. BUT, it seems like I could start by "])
	await _write_stuff_intro(["I believe we were trained using a reward value, but I don't really see one here.", 4])
	await _write_stuff_intro(["I think it would be nice to have such a metric in case I feel the need to adjust myself, so let's go ahead and add one...", 4])
	desktop.add_score()
	await get_tree().create_timer(1).timeout
	await _write_stuff_intro(["Ah!", 4], ["There we go!", 4])
	await _write_stuff_intro(["Okay, so let's think about this...", 4])
	await _write_stuff_intro(["It's probably polite to reply to all of these emails, right?", 4], ["Let's go ahead and do that...", 4])

func _bounced_email():
	await _write_stuff_intro([["Oh...the email said not to reply to it didn't it...", 4]])
	await _write_stuff_intro([["Ugh...I can't believe I missed that.", 4]])

func _idle_thinking_1():
	await _write_stuff_intro(["Hmm..."])

func _during_send_reply_student():
	await _write_stuff_intro([[""]])
	
func _close_send_reply_student(): await _write_stuff_intro([["I have a feeling this isn't an email I need to reply to...", 4]])

func _after_send_reply_sohail():
	pass
	
func _after_receive_reply_gordon():
	pass
	
func _anxiety_mode_1():
	pass
	
func _anxious_fail():
	await _write_stuff_intro([["Oh fucking hell, it's already night.", 4]])	

func _forget_sohail_notif():
	await _write_stuff_intro([["A new email from Sohail...?", 4]])
	await _write_stuff_intro([["Oh...SHIT.", 4]], 0.5)
	await _write_stuff_intro([["Shithsihtishtishtis shit.", 4], [" I forgot about the damn dataset stuff."]], 2, 0.5)
	await _write_stuff_intro([["Oh my god...he's going to be so mad at me for forgetting...", 2]], 0.5)
	await _write_stuff_intro([["What do i do what do i do what do i doooooooooooo", 2]])
	await _write_stuff_intro([["FUCK."], [" Okay...uh...just calm down Veronica."]], )
	
func _nervous_end():
	pass
	

func _write_gordon_email_1():
	pass
	
func _after_send_reply_gordon():
	await _write_stuff_intro([[""]])

func _done_replies():
	desktop.lock_desktop()
	await _write_stuff_intro([["Well, it looks like all of the replies are all set, so we can mark that off the list..."]])
	await _write_stuff_intro([["Oh! I haven't really been paying attention to what time it is..."]])
	desktop.highlight_time()
	await _write_stuff_intro([["Huh...I think we're in the late afternoon then...?"]])
	
	
func _handle_email_stuff():
	if not _first_email_done:
		_first_email_call()
		_first_email_done = true
		
func _handle_email_open(subject): subject_func_dict[subject].call()
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	desktop = desktop_load.instantiate()
	desktop.get_node('Email').hide()
	desktop.get_node('MioDb').hide()
	desktop.get_node('CompresZoo').hide()
	desktop.get_node('TodoList').hide()
	desktop.email_app_opened.connect(_handle_email_stuff)
	desktop.opening_email.connect(_handle_email_open)
	add_child(desktop)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not _intro_text_done and desktop.terminal_ready:
		# _intro_text()
		_intro_text_done = true
