extends Control

signal freeze_character

var dialogue
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
	if dialogue_index < dialogue.size():
		dialogue_completed = false
		finished = false
		$RichTextLabel.bbcode_text = dialogue[dialogue_index]
		$RichTextLabel.percent_visible = 0
		$Tween.interpolate_property(
			$RichTextLabel, "percent_visible", 0, 1, 1, 
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		$Tween.start()
		dialogue_index += 1
	else:
		self.visible = false
		interacted = false
		dialogue_index = 0
		dialogue_completed = true
		emit_signal("freeze_character", false)

func _on_Tween_tween_completed(_object, _key):
	finished = true;
	
func _on_Player_interactable(isInteractable, message):
	interactable = isInteractable
	if dialogue_completed:
		dialogue = message
		
