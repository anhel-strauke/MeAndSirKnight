extends Sprite

# Called when the node enters the scene tree for the first time.
func _ready():	
	pass # Replace with function body.

func _input(event):
	if get_tree().paused:
		if event is InputEventMouseButton and not event.is_pressed():
			get_tree().paused = false
			get_parent().hide()

