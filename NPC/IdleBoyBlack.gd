extends KinematicBody2D

onready var animationPlayer = $AnimationPlayer

func _ready():
	animationPlayer.play("Idle")
