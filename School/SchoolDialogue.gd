extends Control

signal freeze_character
signal dialogue_complete

onready var typing = $AudioStreamPlayer
onready var playerAnimation = $Player/AnimationPlayer
onready var friendAnimation = $Friend/AnimationPlayer

var dialogue = [
	"Player",
		"Oh...hi.",
	"Friend",
		"We missed you at practice last night!",
		"We got dinner after at that new place down the street.",
		"When are you gonna be back?",
	"Player",
		"... (Is she serious? I'm clearly in no condition to play.)",
		"Choice",
			"Does it look like I'm coming back anytime soon?",
			"I'm not. I don't...I don't think I'm going to come back",
			"...",
	"Friend",
		"Response",
			"What are you yelling at me for?! What's gotten into you?",
			"Come on, volleyball is your life! You can't quit now because of a small setback!",
			"Please...we haven't talked in a while and I'm tired of you ignoring me.",
	"Player",
		"Response",
			"Just go away. I'm not interested in talking right now.",
			"Are you serious?! A SMALL setback?! Open your eyes, dude!",
			"There's nothing to talk about. I'll see you later.",
	"Friend",
		"Fine. Be that way.",
		"Have fun in Chemistry today. Did you remember that we have a quiz?",
	"Player",
		"Honestly, I couldn't care less."
]
var dialogue_index = 0
var finished = true
var dialogue_completed = true
var interactable = false
var interacted = false
var choice = 0
var waiting_for_response
var response = ""
var scene_finished = false

signal scene_finished
	
func _process(_delta):
	if Input.is_action_just_pressed("ui_interact") and interactable and finished:
		self.visible = true
		emit_signal("freeze_character", true)
		load_dialogue()
	
func load_dialogue():
	if dialogue.size() > 0 and dialogue_index < dialogue.size():
		if dialogue[dialogue_index] == "Player":
			$Friend.visible = false
			$Player.visible = true
			dialogue_index += 1
			load_dialogue()
		elif dialogue[dialogue_index] == "Friend":
			$Player.visible = false
			$Friend.visible = true
			dialogue_index += 1
			load_dialogue()
		elif dialogue[dialogue_index] == "Choice":
			$Options.visible = true
			$RichTextLabel.visible = false
			dialogue_index += 1
			$Options/Option1/Button.text = dialogue[dialogue_index]
			dialogue_index += 1
			$Options/Option2/Button.text = dialogue[dialogue_index]
			dialogue_index += 1
			$Options/Option3/Button.text = dialogue[dialogue_index]
			dialogue_index += 1
			waiting_for_response = true
		elif dialogue[dialogue_index] == "Response":
			response = dialogue[dialogue_index + choice]
			dialogue_index += 4
			load_set_dialogue(response)
		else:
			dialogue_completed = false
			emit_signal("dialogue_complete", false)
			finished = false
			if(dialogue[dialogue_index] == "..." or "(" in dialogue[dialogue_index]):
				playerAnimation.play("Stop")
				friendAnimation.play("Stop")
			else:
				playerAnimation.play("Talk")
				friendAnimation.play("Talk")
			$RichTextLabel.bbcode_text = dialogue[dialogue_index]
			typing.play()
			$RichTextLabel.percent_visible = 0
			$Tween.interpolate_property(
				$RichTextLabel, "percent_visible", 0, 1, 1, 
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
			)
			$Tween.start()
			dialogue_index += 1
	else:
		if dialogue_index >= dialogue.size():
			SceneChanger.change_scene("res://Levels/ChemClass.tscn", "fade")
#			scene_finished = true
#			emit_signal("scene_finished")
		self.visible = false
		playerAnimation.stop(true)
		friendAnimation.stop(true)
		typing.stop()
		interacted = false
		dialogue_index = 0
		dialogue_completed = true
		emit_signal("dialogue_complete", true)
		emit_signal("freeze_character", false)

func _on_Tween_tween_completed(_object, _key):
	finished = true;
	
func _on_Player_interactable(is_interactable, _interactable_area):
	if dialogue_completed and is_interactable:
		interactable = true
		
func load_set_dialogue(set_dialogue):
	$RichTextLabel.visible = true
	$Options.visible = false
	dialogue_completed = false
	finished = false
	if(set_dialogue == "..."):
		playerAnimation.play("Stop")
		friendAnimation.play("Stop")
	else:
		playerAnimation.play("Talk")
		friendAnimation.play("Talk")
	$RichTextLabel.bbcode_text = set_dialogue
	$RichTextLabel.percent_visible = 0
	$Tween.interpolate_property(
		$RichTextLabel, "percent_visible", 0, 1, 1, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	$Tween.start()
		
func _on_Option1_pressed():
	choice = 1
	waiting_for_response = false
	load_dialogue()

func _on_Option2_pressed():
	choice = 2
	waiting_for_response = false
	load_dialogue()

func _on_Option3_pressed():
	choice = 3
	waiting_for_response = false
	load_dialogue()
