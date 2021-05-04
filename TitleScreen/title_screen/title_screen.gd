extends Control
onready var titleMusic = $TitleMusic

func _ready():
	$Menu/CenterRow/Buttons/NewGameButton.grab_focus()
	for button in $Menu/CenterRow/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
		titleMusic.play()

func _on_Button_pressed(_scene_to_load):
	SceneChanger.change_scene("res://Levels/Intro.tscn", "fade")
	if titleMusic.playing == true:
		titleMusic.stop()
