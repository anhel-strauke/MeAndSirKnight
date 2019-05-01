extends Node2D

var lifetime = 1.0
var _time = 0.0
var endpoint: Vector2 = Vector2(0.0, -50.0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_value(val: int):
	$Label.text = str(val)
	
func set_color(col: Color):
	$Label.add_color_override("font_color", col)

func _process(delta):
	_time += delta
	var progress = _time / lifetime
	if progress > 1.0:
		progress = 1.0
	position = Vector2(endpoint.x * progress, endpoint.y * progress)
	if _time >= lifetime:
		hide()
		queue_free()
