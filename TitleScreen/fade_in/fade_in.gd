extends ColorRect

signal fade_finished

func fade_in():
	$AnimationPlayer.play("fade-in")
	
func fade_out():
	$AnimationPlayer.play("fade-out")

func _on_AnimationPlayer_animation_finished(anim_name):
		emit_signal("fade_finished")
