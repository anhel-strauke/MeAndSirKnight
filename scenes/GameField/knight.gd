extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var data = preload("res://data/weapon_data.gd").new()
var weapon_data = data.weapons

export var hitpoints: int = 0
export var weapon_type: String = "sword"
export var attacking: bool = false

var cooldown_time = 1.0
var attack_time = 1.0
var weapon_hit_count = {}

signal damage_done(damage)

const MIN_DAMAGE = 2.0

var is_weapon_going_down = true
var time_since_action = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	# initiate weapon hit count storage
	for wtype in weapon_data:
		weapon_hit_count[wtype] = 0

func durability_func(hit_count):
	var loss_table = weapon_data[weapon_type]["penalty"]
	if hit_count >= len(loss_table):
		return loss_table[len(loss_table) - 1]
	return loss_table[hit_count]

func calc_damage():
	var min_damage = weapon_data[weapon_type]["min_damage"]
	var max_damage = weapon_data[weapon_type]["max_damage"]
	var hit_count = weapon_hit_count[weapon_type]
	var damage = rand_range(min_damage, max_damage) - durability_func(hit_count)
	if damage < MIN_DAMAGE:
		damage = MIN_DAMAGE
	return damage

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if attacking:
		if is_weapon_going_down:
			if time_since_action >= attack_time:
				do_attack()
			else:
				time_since_action += delta
		else:
			if time_since_action >= cooldown_time:
				do_weapon_reset()
			else:
				time_since_action += delta

func do_attack():
	# TODO: Run animation
	var damage = calc_damage()
	print("Knight deals damage: ", damage, "; cooldown: ", cooldown_time, " sec")
	emit_signal("damage_done", damage)
	time_since_action = 0.0
	is_weapon_going_down = false
	weapon_hit_count[weapon_type] += 1
	# TODO: Update weapon state

func do_weapon_reset():
	# TODO: Run animation
	is_weapon_going_down = true
	time_since_action = 0.0
	
func replace_weapon(new_weapon_type):
	if weapon_type != new_weapon_type:
		weapon_type = new_weapon_type
		attack_time = weapon_data[weapon_type]["attack_time"]
		cooldown_time = weapon_data[weapon_type]["cooldown_time"]

func can_replace_weapon():
	return is_weapon_going_down
