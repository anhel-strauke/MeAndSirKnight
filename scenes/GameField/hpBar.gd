extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func set_value(var hp):
	var size = $bar.texture.get_size().x
	$bar.set_scale(Vector2(hp, 1)) 
	$second.set_position(Vector2($second.get_position().x - (size - $bar.texture.get_size().x * hp), $second.get_position().y))

func _ready():
	set_value(0.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
