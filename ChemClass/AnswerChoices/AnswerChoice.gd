extends NinePatchRect

onready var checkbox = $CheckBox

func _ready():
	checkbox.add_color_override("font_color_pressed", checkbox.get_color("font_color_pressed").linear_interpolate( Color("000000"),1.0))
	checkbox.add_color_override("font_color_hover", checkbox.get_color("font_color_hover").linear_interpolate( Color("888888"),1.0))
