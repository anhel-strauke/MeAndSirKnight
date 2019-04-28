extends Node2D

var enemy_data = preload("res://data/game_data.gd").new().enemies

signal damage_done(damage)
signal hp_changed(hp, maxhp)
signal dying()
signal finally_dead()

export var enemy_type = "enemy_1"
export var attacking = false
export var hitpoints: float = 0.0
var total_hitpoints = 1.0

var min_damage = 0.0
var max_damage = 0.0
var cooldown_time = 0.0
var time_since_attack = 0.0

func begin_battle():
	attacking = true

# Called when the node enters the scene tree for the first time.
func _ready():
	var my_data = enemy_data[enemy_type]
	min_damage = my_data["min_damage"]
	max_damage = my_data["max_damage"]
	cooldown_time = my_data["cooldown_time"]
	hitpoints = my_data["hitpoints"]
	total_hitpoints = hitpoints
	time_since_attack = 0.0
	attacking = false
	
func calc_damage():
	var dmg = rand_range(min_damage, max_damage)
	return dmg

func _on_hit():
	var dmg = calc_damage()
	emit_signal("damage_done", dmg)

func do_hit():
	$AnimationPlayer.play("hit")
	time_since_attack = 0.0

func take_damage(damage):
	if hitpoints > 0:
		hitpoints -= damage
		if hitpoints <= 0:
			become_dead()
			hitpoints = 0
		emit_signal("hp_changed", hitpoints, total_hitpoints)

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
