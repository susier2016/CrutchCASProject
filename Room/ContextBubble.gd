extends Area2D

onready var animationPlayer = $HoverAnimation
var interactable = false

func _process(delta):
	if Input.is_action_just_pressed("ui_interact") and interactable:
		self.visible = false

func _on_ContextBubble_area_entered(area):
	interactable = true
	self.visible = true
	animationPlayer.play("Hover")

func _on_ContextBubble_area_exited(area):
	interactable = false
	self.visible = false
	animationPlayer.stop(true)
	
