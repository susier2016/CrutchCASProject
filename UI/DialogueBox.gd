extends Control

signal freeze_character
signal dialogue_complete
signal objects_interacted

onready var animationPlayer = $AnimationPlayer

var dialogue
var dialogue_index = 0
var finished = true
var dialogue_completed = true
var interactable = false
var interacted = false
var objects_interacted = []
var current_area = null
var can_go_to_school = false
	
func _process(_delta):
	if Input.is_action_just_pressed("ui_interact") and interactable and finished:
		if !objects_interacted.has(current_area.get_parent().get_name()):
			objects_interacted.append(current_area.get_parent().get_name())
		self.visible = true
		emit_signal("objects_interacted", objects_interacted)
		emit_signal("freeze_character", true)
		load_dialogue()
	
func load_dialogue():
	if dialogue.size() > 0 and dialogue_index < dialogue.size():
		dialogue_completed = false
		emit_signal("dialogue_complete", false)
		finished = false
		if(dialogue[dialogue_index] == "..."):
			animationPlayer.play("Stop")
		else:
			animationPlayer.play("Talk")
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
		animationPlayer.stop(true)
		interacted = false
		dialogue_index = 0
		dialogue_completed = true
		emit_signal("dialogue_complete", true)
		emit_signal("freeze_character", false)
		if can_leave:
			

func _on_Tween_tween_completed(_object, _key):
	finished = true;
	
func _on_Player_interactable(is_interactable, interactable_area):
	interactable = is_interactable
	if dialogue_completed and is_interactable:
		current_area = interactable_area
		dialogue = interactable_area.interact()
		
func _on_Door_can_go_to_school(can_leave):
	can_go_to_school = can_leave
