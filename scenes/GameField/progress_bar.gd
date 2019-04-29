extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var progress: float = 1.0 setget set_progress, get_progress

var middle: Sprite = null
var right_side: Sprite = null
var left_side: Sprite = null

const norm_height = 4
const norm_width = 77
const norm_side_width = 4
const norm_full_width = norm_width + 2 * norm_side_width

var norm_pos_y = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	middle = $middle
	right_side = $right_side
	left_side = $left_side
	norm_pos_y = right_side.position.y

func set_progress(prog):
	if prog < 0:
		prog = 0.0
	elif prog > 1.0:
		prog = 1.0
	progress = prog
	var new_full_w = round(prog * norm_full_width)
	if new_full_w > 2 * norm_side_width:
		var mid_w = new_full_w - 2 * norm_side_width
		middle.visible = true
		right_side.visible = true
		left_side.visible = true
		middle.region_rect = Rect2(0, 0, mid_w, norm_height)
		right_side.position = Vector2(middle.position.x + mid_w, norm_pos_y)
	elif new_full_w > 0:
		middle.visible = false
		right_side.visible = false
		left_side.visible = true
	else:
		middle.visible = false
		right_side.visible = false
		left_side.visible = false

func get_progress():
	return progress
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
