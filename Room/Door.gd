extends StaticBody2D

var objects_interacted = []
signal can_go_to_school

func _on_DialogueBox_objects_interacted(objects):
	if objects_interacted.has("Desk") and objects_interacted.has("Bed") and objects_interacted.has("Closet") and objects_interacted.has("TrophyCase"):
		emit_signal("can_go_to_school", true)
	else:
		emit_signal("can_go_to_school", false)
	objects_interacted = objects
