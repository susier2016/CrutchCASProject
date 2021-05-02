extends Area2D

onready var animationPlayer = $HoverAnimation
var interactable = false

func _process(_delta):
	if get_overlapping_areas().size() > 0 and !get_parent().frozen:
		interactable = true
		self.visible = true
		animationPlayer.play("Hover")
	else:
		interactable = false
		self.visible = false
		animationPlayer.stop(true)
	if Input.is_action_just_pressed("ui_interact") and interactable:
		self.visible = false

func _on_ContextBubble_area_entered(_area):
	interactable = true
	self.visible = true
	animationPlayer.play("Hover")

func _on_ContextBubble_area_exited(_area):
	interactable = false
	self.visible = false
	animationPlayer.stop(true)
