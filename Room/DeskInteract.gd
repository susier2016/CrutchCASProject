extends Area2D

onready var lampSound = get_parent().get_node("LampSound")
onready var animationPlayer = get_parent().get_node("AnimationPlayer")
var interacted = false

func _process(_delta):
	if Input.is_action_just_pressed("ui_interact") and get_overlapping_areas().size() > 0 and get_parent().dialogue_completed:
		interacted = true
		lampSound.play()
		if(animationPlayer.current_animation == "LightOn"):
			animationPlayer.play("LightOff")	
		else:
			animationPlayer.play("LightOn")
		
			

func interact():
	if(!interacted):
		return ["Oh, ****!", "That's what I forgot. The chemistry quiz.", "I've just been...getting so far behind in all of my classes...", "It's just so hard to focus."]
	else:
		return []
