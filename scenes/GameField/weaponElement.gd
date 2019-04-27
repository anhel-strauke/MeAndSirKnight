extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#warning-ignore:unused_class_variable
export var item_name = ""

func set_dimmed(var state):
	if (state): 
		 $weapon.modulate = Color("#4c4c4c")
	else:
		 $weapon.modulate = Color("#ffffff")
	pass
var selected= false
func set_selected(var state):
	$Node2D.visible = state
	selected=state
	pass

signal clicked(name) 

#func _input_event(viewport, event, shape_idx):
#
#	pass
#
	 
# Called when the node enters the scene tree for the first time.
func _ready():
	item_name=name
	set_selected(false)
	set_dimmed(false)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_weaponElement_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("click_left"):
		print("Sending clicked ", item_name)
		emit_signal("clicked", item_name)
	pass # Replace with function body.
