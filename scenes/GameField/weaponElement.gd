extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#warning-ignore:unused_class_variable
export var item_name = ""

signal clicked(name) 

#func _input_event(viewport, event, shape_idx):
#
#	pass
#
	 
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_weaponElement_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("click_left"):
		emit_signal("clicked", item_name)
	pass # Replace with function body.
