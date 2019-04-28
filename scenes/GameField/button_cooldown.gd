extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var progress = 0 setget set_progress, get_progress
export var max_progress = 10 setget set_max_progress, get_max_progress

# Called when the node enters the scene tree for the first time.
func _ready():
	play_small_cooldown()
	pass # Replace with function body.
	
func is_finished():
	return progress >= max_progress
	
func play_small_cooldown():
	$AnimationPlayer.play("small_cooldown")
	
func set_progress(p):
	if p <= max_progress:
		progress = p
	else:
		progress = max_progress
	_update_frame()
	
func set_max_progress(p):
	if p > 0:
		max_progress = p
		set_process(progress)
	else:
		max_progress = 1
		set_progress(progress)
		
func get_progress():
	return progress
	
func get_max_progress():
	return max_progress
	
func _update_frame():
	if $button_cooldown:
		if max_progress > 0:
			var amount = progress / (max_progress as float)
			var max_frame = $button_cooldown.hframes
			var fr = round(max_frame * amount)
			if fr < max_frame:
				$button_cooldown.visible = true
				$button_cooldown.frame = fr
			else:
				$button_cooldown.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
