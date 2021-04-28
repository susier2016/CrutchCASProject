# SUSIE - Testing commits

extends KinematicBody2D
	
const ACCELERATION = 100
const MAX_SPEED = 15
const FRICTION = 400

var velocity = Vector2.ZERO
var frozen = false
var direction_vector

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
export var interaction_parent : NodePath

signal interactable

func _physics_process(delta):
	if !frozen:
		var input_vector = Vector2.ZERO
		input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		input_vector = input_vector.normalized()
		
		if input_vector != Vector2.ZERO:
			animationTree.set("parameters/Idle/blend_position", input_vector)
			animationTree.set("parameters/Run/blend_position", input_vector)
			animationState.travel("Run")
			velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		
			direction_vector = input_vector * 10
		else: 
			animationState.travel("Idle")
			#facing_interactable = rayCast.is_colliding()
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
		velocity = move_and_slide(velocity)

func _on_ContextBubble_area_entered(area: Area2D)->void:
	#print(str(area))
	if area.has_method("interaction_interact"):
		print("player: interactable")
		emit_signal("interactable", true, area.interaction_interact())

func _on_ContextBubble_area_exited(area: Area2D)->void:
	emit_signal("interactable", false, null)

func _on_DialogueBox_freeze_character(isFrozen):
	frozen = isFrozen
