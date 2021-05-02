extends CanvasLayer


signal scene_changed()
onready var animation_player = $AnimationPlayer
onready var black = $Control/FadeToBlack


func change_scene(path, delay = 0.5):
	print(get_parent().get_children())
	$Control/FadeToBlack.show()
	yield(get_tree().create_timer(delay), "timeout")
	animation_player.play("fade-in")
	yield(animation_player, "animation_finished")
	var _k = get_tree().change_scene(path)
	animation_player.play("fade-out")
	$Control/FadeToBlack.hide()
	emit_signal("scene_changed")
