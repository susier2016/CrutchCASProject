extends Sprite


onready var animationPlayer = $AnimationPlayer3

func _ready():
	animationPlayer.play("BuildingsMoving")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

