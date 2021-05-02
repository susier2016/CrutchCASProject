extends StaticBody2D

var objects_interacted = []
signal can_go_to_school

func _on_DialogueBox_objects_interacted(objects):
	print(objects_interacted)
	if objects_interacted.size() >= 4:
		emit_signal("can_go_to_school", true)
	else:
		emit_signal("can_go_to_school", false)
	objects_interacted = objects
