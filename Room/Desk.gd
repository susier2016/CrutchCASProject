extends StaticBody2D

var dialogue_completed = true

func _on_DialogueBox_dialogue_complete(isComplete):
	dialogue_completed = isComplete
