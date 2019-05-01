extends Node2D

const DamagePoint = preload("res://scenes/GameField/effects/damage_point.tscn")

export var color: Color = Color(1.0, 1.0, 1.0)
export var height = 50.0
export var width_range = 30.0
export var lifetime = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_point(value: int):
	var new_point = DamagePoint.instance()
	new_point.set_value(value)
	new_point.set_color(color)
	new_point.endpoint = Vector2(round(rand_range(-width_range, width_range)), -height)
	new_point.lifetime = lifetime
	add_child(new_point)
	
