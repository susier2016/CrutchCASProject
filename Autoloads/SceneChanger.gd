extends CanvasLayer

onready var animation_player = $AnimationPlayer
onready var black = $Control/FadeToBlack
var scene

func change_scene(new_scene, anim):
	scene = new_scene
	animation_player.play(anim)
	
func _new_scene():
	var _y = get_tree().change_scene(scene)
