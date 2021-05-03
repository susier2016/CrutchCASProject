extends KinematicBody2D

onready var driving = $DrivingMusic
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
		
func _on_DialogueBox_scene_finished():
	scene_complete = true

