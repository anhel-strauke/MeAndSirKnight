extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():	
	pass # Replace with function body.

func _input(event):
	if get_tree().paused:
		if event is InputEventMouseButton and not event.is_pressed():
			get_tree().paused = false
			get_parent().hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
