extends Control

signal freeze_character
signal dialogue_complete

onready var quizMusic = get_node("QuizMusic")
onready var typing = $AudioStreamPlayer
onready var playerAnimation = $Player/AnimationPlayer
onready var teacherAnimation = $Teacher/AnimationPlayer

var dialogue = [
	"Teacher",
		"Okay, class. Everyone get your pencils and calculators out.",
		"It's time for the quiz!"
]

var dialogue_index = 0
var finished = true
var dialogue_completed = true
var interactable = false
var interacted = false

signal scene_finished

func _process(_delta):
	if Input.is_action_just_pressed("ui_interact") and interactable and finished:
		self.visible = true
		emit_signal("freeze_character", true)
		load_dialogue()
		if quizMusic.playing == false:
			quizMusic.play()
	
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
		if dialogue_index >= dialogue.size():
			emit_signal("scene_finished")
			emit_signal("freeze_character", true)
		else:
			emit_signal("freeze_character", false)
		self.visible = false
		playerAnimation.stop(true)
		teacherAnimation.stop(true)
		typing.stop()
		interacted = false
		dialogue_index = 0
		dialogue_completed = true
		emit_signal("dialogue_complete", true)

func load_set_dialogue(set_dialogue):
	self.visible = true
	$Teacher.visible = false
	$Player.visible = true
	$RichTextLabel.visible = true
	dialogue_completed = false
	finished = false
	if(set_dialogue == "..."):
		playerAnimation.play("Stop")
	else:
		playerAnimation.play("Talk")
	$RichTextLabel.bbcode_text = set_dialogue
	$RichTextLabel.percent_visible = 0
	$Tween.interpolate_property(
		$RichTextLabel, "percent_visible", 0, 1, 1, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	$Tween.start()

func _on_Tween_tween_completed(_object, _key):
	finished = true;
	
func _on_Player_interactable(is_interactable, _interactable_area):
	if dialogue_completed and is_interactable:
		interactable = true

func _on_Quiz_quiz_finished():
	#load_set_dialogue("God...I totally bombed that quiz.")
	#yield($Tween, "tween_completed")
	SceneChanger.change_scene("res://Levels/ToBeContinued.tscn", "fade")
