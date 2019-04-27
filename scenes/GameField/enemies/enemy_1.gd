extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var enemy_data = preload("res://data/game_data.gd").new().enemies

signal damage_done(damage)
signal hp_changed(hp)
signal dying()
signal finally_dead()

export var enemy_type = "enemy_1"
export var attacking = false
export var hitpoints: float = 0.0

var min_damage = 0.0
var max_damage = 0.0
var cooldown_time = 0.0
var time_since_attack = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	var my_data = enemy_data[enemy_type]
	min_damage = my_data["min_damage"]
	max_damage = my_data["max_damage"]
	cooldown_time = my_data["cooldown_time"]
	if hitpoints <= 0:
		hitpoints = my_data["hitpoints"]
	time_since_attack = 0.0
	
func calc_damage():
	var dmg = rand_range(min_damage, max_damage)
	return dmg

func do_hit():
	$AnimationPlayer.play("hit")
	time_since_attack = 0.0

func take_damage(damage):
	if hitpoints > 0:
		hitpoints -= damage
		if hitpoints <= 0:
			become_dead()
			hitpoints = 0
		emit_signal("hp_changed", hitpoints)

func become_dead():
	emit_signal("dying")
	attacking = false
	$AnimationPlayer.play("death")
	
func _on_dead_animation_end():
	visible = false
	emit_signal("finally_dead")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if attacking:
		if time_since_attack > cooldown_time:
			do_hit()
		else:
			time_since_attack += delta

