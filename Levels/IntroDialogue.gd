extends Control

onready var typing = $AudioStreamPlayer

var dialogue = ["Where is...my crutch...", "Oh. There it is...", "...guess it's time to get up."]
var dialogue_index = 0
var finished = true
var dialogue_completed = true

func _process(_delta):
	if Input.is_action_just_pressed("ui_interact") and finished:
		self.visible = true
		load_dialogue()
	
func load_dialogue():
	if dialogue.size() > 0 and dialogue_index < dialogue.size():
		dialogue_completed = false
		finished = false
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
		typing.stop()
		dialogue_index = 0
		dialogue_completed = true
		SceneChanger.change_scene("res://Levels/Bedroom.tscn", "fade")

func _on_Tween_tween_completed(_object, _key):
	finished = true;

func _on_Timer_timeout():
	self.visible = true
	load_dialogue()
