extends Sprite

onready var animationPlayer = $AnimationPlayer2
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _ready():
	animationPlayer.play("RoadMoving")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
