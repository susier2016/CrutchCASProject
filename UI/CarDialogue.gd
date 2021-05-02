extends Control

onready var playerAnimation = $Player/AnimationPlayer
onready var momAnimation = $Mom/AnimationPlayer

var dialogue = [
	"Mom",
	"...",
	"So...",
	"...you skipped History yesterday.",
	"...",
	"No answer? Okay.",
	"This is the fourth time, but go ahead and ignore me.",
	"Player",
	"Die"
	]
var dialogue_index = 0
var finished = true
var dialogue_completed = true
	
func _process(_delta):
	if Input.is_action_just_pressed("ui_interact") and finished:
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
		else:
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
		self.visible = false
		playerAnimation.stop(true)
		dialogue_index = 0
		dialogue_completed = true

func _on_Tween_tween_completed(_object, _key):
	finished = true;
