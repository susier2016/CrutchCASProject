extends Control

signal freeze_character
signal dialogue_complete

onready var typing = $AudioStreamPlayer
onready var playerAnimation = $Player/AnimationPlayer
onready var teacherAnimation = $Teacher/AnimationPlayer

var dialogue = [
	"Player",
		"Well, I guess it's time to get this quiz started.",
	"Teacher",
		"Okay, class. Everyone get your calculators out.",
		"It's time for the quiz!"
]
var dialogue_index = 0
var finished = true
var dialogue_completed = true
var interactable = false
var interacted = false
	
func _process(_delta):
	if Input.is_action_just_pressed("ui_interact") and interactable and finished:
		self.visible = true
		emit_signal("freeze_character", true)
		load_dialogue()
	
func load_dialogue():
	if dialogue.size() > 0 and dialogue_index < dialogue.size():
		if dialogue[dialogue_index] == "Player":
			$Teacher.visible = false
			$Player.visible = true
			dialogue_index += 1
			load_dialogue()
		elif dialogue[dialogue_index] == "Teacher":
			$Player.visible = false
			$Teacher.visible = true
			dialogue_index += 1
			load_dialogue()
		else:
			dialogue_completed = false
			emit_signal("dialogue_complete", false)
			finished = false
			if(dialogue[dialogue_index] == "..."):
				playerAnimation.play("Stop")
				teacherAnimation.play("Stop")
			else:
				playerAnimation.play("Talk")
				teacherAnimation.play("Talk")
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
		self.visible = false
		playerAnimation.stop(true)
		teacherAnimation.stop(true)
		typing.stop()
		interacted = false
		dialogue_index = 0
		dialogue_completed = true
		emit_signal("dialogue_complete", true)
		emit_signal("freeze_character", false)

func _on_Tween_tween_completed(_object, _key):
	finished = true;
	
func _on_Player_interactable(is_interactable, interactable_area):
	if dialogue_completed and is_interactable:
		interactable = true
