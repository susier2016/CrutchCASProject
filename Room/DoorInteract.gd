extends Area2D

onready var door = get_parent()
signal go_to_school

func interact():
	if get_parent().objects_interacted.size() >= 4:
		return["Fine...I guess I'll get to school."]
	else:
		return ["Not...not yet. I'm not ready to face the outside world. It's safer in here...", "...by myself."]
