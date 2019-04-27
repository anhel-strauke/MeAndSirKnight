extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _sethp(var hp):
	var size=$bar.texture.get_size()[0]
	$bar.set_scale(Vector2(hp,1)) 
	$second.set_position(Vector2($second.get_position()[0]-(size- $bar.texture.get_size()[0]*hp),$second.get_position()[1]))
	pass


func _ready():
	_sethp(0.5)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
