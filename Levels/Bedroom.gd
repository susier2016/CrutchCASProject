extends YSort

onready var bedroomMusic = $BedroomMusic
func _ready():
	if bedroomMusic.playing == false:
		bedroomMusic.play()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
