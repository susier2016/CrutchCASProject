extends NinePatchRect

signal pressed

func _on_Button_pressed():
	print("pressed")
	emit_signal("pressed")

func _on_Button_focus_entered():
	print("focused")
