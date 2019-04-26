extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var next_scene: String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_splash_animation_finished(anim_name):
	if anim_name == "show":
		if len(next_scene) > 0:
			get_tree().change_scene(next_scene)
		else:
			get_tree().quit()

func _input(event):
	if event.is_action_released("ui_accept") or (event is InputEventMouseButton 
			and event.is_pressed() and event.get_button_index() == BUTTON_LEFT):
		if $splash_animation.current_animation_position < $splash_animation.current_animation_length - 0.3:
			$splash_animation.seek($splash_animation.current_animation_length - 0.3, true)