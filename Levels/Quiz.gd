extends TextureRect

var can_start = false

func _process(_delta):
	if can_start:
		rect_position.y -= 0.25
		
func _on_DialogueBox_scene_finished():
	self.visible = true
	can_start = true
