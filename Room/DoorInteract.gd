extends Area2D

onready var door = get_parent()
signal go_to_school

func interact():
	if door.objects_interacted.has("Desk") and door.objects_interacted.has("Bed") and door.objects_interacted.has("Closet") and door.objects_interacted.has("TrophyCase"):
		return["Fine...I guess I'll get to school."]
		emit_signal("go_to_school")
	else:
		return ["Not...not yet. I'm not ready to face the outside world. It's safer in here...", "...by myself."]
