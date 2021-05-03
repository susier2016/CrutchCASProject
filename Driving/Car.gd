extends KinematicBody2D

onready var driving = get_parent().get_node("Car/DrivingMusic")
onready var animationPlayer = $AnimationPlayer
var scene_complete

func _ready():
	animationPlayer.play("Driving")
	if driving.playing == false:
		driving.play()

func _process(_delta):
	if !scene_complete and position.x < 79:
		position.x += 0.75
	elif scene_complete and position.x < 175:
		position.x += 0.75
	elif position.x >= 175:
		driving.stop()
		
func _on_DialogueBox_scene_finished():
	scene_complete = true

