extends TextureRect

var can_start = false

signal quiz_finished

func _process(_delta):
	if can_start and rect_position.y >= -295:
		rect_position.y -= 0.17
	if rect_position.y < -295:
		emit_signal("quiz_finished")
		
func _on_DialogueBox_scene_finished():
	self.visible = true
	can_start = true
