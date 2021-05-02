extends KinematicBody2D

onready var animationPlayer = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	animationPlayer.play("BestFriend")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
