extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#warning-ignore:unused_class_variable
export var item_name = ""

signal clicked(name)
signal mouse_over(name)

var selected = false
var dimmed = false
var mouse_over_now = false

var cooldown = null
func set_tip(var state):
	if(state):
		$tip.play("helpScale")
	else:
		$tip.stop(true)


func set_selected(var state):
	$selection.visible = state
	selected = state
	
func play_cooldown(max_progress):
	if cooldown:
		cooldown.set_max_progress(max_progress)
		cooldown.set_progress(0)
	
func update_cooldown(progress):
	if cooldown:
		cooldown.set_progress(progress)
		
func end_cooldown():
	if cooldown:
		cooldown.set_progress(cooldown.max_progress)
		
func play_small_cooldown():
	if cooldown:
		cooldown.play_small_cooldown()

#func _input_event(viewport, event, shape_idx):
#
#	pass
#

func set_dimmed(var state):
	if (state): 
		 $weapon.modulate = Color("#4c4c4c")
	else:
		 $weapon.modulate = Color("#ffffff")
	dimmed = state

	 
# Called when the node enters the scene tree for the first time.
func _ready():
	set_tip(false)
	set_selected(false)
	set_dimmed(false)
	connect("mouse_entered", self, "_set_mouse_over")
	connect("mouse_exited", self, "_reset_mouse_over")
	cooldown = $button_cooldown
	end_cooldown()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func is_mouse_over():
	return mouse_over_now

func _set_mouse_over():
	set_tip(true)
	mouse_over_now = true

func _reset_mouse_over():
	set_tip(false)
	mouse_over_now = false

func _on_weaponElement_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		if not dimmed and (not cooldown or cooldown.is_finished()):
			emit_signal("clicked", item_name)
