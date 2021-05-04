extends YSort

onready var bedroomMusic = $BedroomMusic
func _ready():
	if bedroomMusic.playing == false:
		bedroomMusic.play()
