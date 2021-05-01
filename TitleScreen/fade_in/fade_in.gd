extends ColorRect

signal fade_finished

func fade_in():
	$AnimationPlayer.play("fade-in")
	
func fade_out():
	#$AnimationPlayer.play("fade-out")
	$AnimationPlayer.play_backwards("fade-in")

func _on_AnimationPlayer_animation_finished(_anim_name):
		emit_signal("fade_finished")
