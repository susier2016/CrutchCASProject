extends Sprite

const VELOCITY: float = -0.25
var g_texture_width: float = 0

func _ready():
	g_texture_width = texture.get_size().x * scale.x
	
func _process(_delta):
	position.x += VELOCITY
	_attempt_reposition()
	
func _attempt_reposition() -> void:
	if position.x < 0:
		position.x += 2 * g_texture_width
	
