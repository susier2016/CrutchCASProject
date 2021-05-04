extends Control

#onready var driving = get_parent().get_parent().get_node("Car/DrivingMusic")
onready var playerAnimation = $Player/AnimationPlayer
onready var momAnimation = $Mom/AnimationPlayer

var started = false
var scene_finished = false
var dialogue = [
	"Mom",
		"...",
		"So...",
		"...you skipped History yesterday.",
	"Player",
		"...",
	"Mom",
		"No answer? Okay.",
		"This is the fourth time, but go ahead and ignore me.",
	"Player",
		"Choice",
			"It's not your business, Mom. Just...just shut up!",
			"I wasn't feeling well. It's harder for me to focus.",
			"I don't know.",
	"Mom",
		"Response",
			"You've got some nerve, talking to me like that. What's gotten into you?",
			"I told you we'd get you a tutor if you need. Volleyball isn't that important.",
			"...of course you don't.",
	"Player",
		"Choice",
			"I'm sorry.",
			"...",
			"What's the point in caring, Mom?! It's just school.",
	"Mom",
		"Response",
			"Forget it, kid. God knows where your head's gone.",
			"Forget it, kid. God knows where your head's gone.",
			"Forget it, kid. God knows where your head's gone.",
	"Mom",
		"Hey, are you still fighting with your friend? What's her name?",
	"Player",
		"..."
]
var dialogue_index = 0
var finished = true
var dialogue_completed = true
var choice = 0
var waiting_for_response
var response = ""

#signal scene_finished

func _process(_delta):
	if Input.is_action_just_pressed("ui_interact") and finished and !scene_finished and started and !waiting_for_response:
		self.visible = true
		load_dialogue()
	
func load_dialogue():
	if dialogue.size() > 0 and dialogue_index < dialogue.size():
		if dialogue[dialogue_index] == "Player":
			$Mom.visible = false
			$Player.visible = true
			dialogue_index += 1
			load_dialogue()
		elif dialogue[dialogue_index] == "Mom":
			$Player.visible = false
			$Mom.visible = true
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
			$RichTextLabel.visible = true
			$Options.visible = false
			dialogue_completed = false
			finished = false
			if(dialogue[dialogue_index] == "..."):
				playerAnimation.play("Stop")
				momAnimation.play("Stop")
			else:
				playerAnimation.play("Talk")
				momAnimation.play("Talk")
			$RichTextLabel.bbcode_text = dialogue[dialogue_index]
			$RichTextLabel.percent_visible = 0
			$Tween.interpolate_property(
				$RichTextLabel, "percent_visible", 0, 1, 1, 
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
			)
			$Tween.start()
			dialogue_index += 1
	else:
		if dialogue_index >= dialogue.size():
			SceneChanger.change_scene("res://Levels/School.tscn", "fade")
#			scene_finished = true
#			emit_signal("scene_finished")
#			driving.stop()
		self.visible = false
		playerAnimation.stop(true)
		dialogue_index = 0
		dialogue_completed = true

func load_set_dialogue(set_dialogue):
	$RichTextLabel.visible = true
	$Options.visible = false
	dialogue_completed = false
	finished = false
	if(set_dialogue == "..."):
		playerAnimation.play("Stop")
		momAnimation.play("Stop")
	else:
		playerAnimation.play("Talk")
		momAnimation.play("Talk")
	$RichTextLabel.bbcode_text = set_dialogue
	$RichTextLabel.percent_visible = 0
	$Tween.interpolate_property(
		$RichTextLabel, "percent_visible", 0, 1, 1, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	$Tween.start()

func _on_Tween_tween_completed(_object, _key):
	finished = true;

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

func _on_Timer_timeout():
	started = true
	self.visible = true
	load_dialogue()
