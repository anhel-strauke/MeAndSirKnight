extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var data = preload("res://data/game_data.gd").new()
var weapon_data = data.weapons
var effects_data = data.effects

export var hitpoints: float = 200
export var total_hitpoints = 100
export var weapon_type: String = ""
export var attacking: bool = false

var next_weapon: String = ""

var cooldown_time = 1.0
var attack_time = 1.0
var weapon_hit_count = {}

var weapon_nodes = {}

signal damage_done(damage)
signal hitpoints_changed(hp, maxhp)
signal weapon_changed()
signal weapon_damaged(weapon)
signal weapon_repaired(weapon)
signal victory()
signal game_over()

const MIN_DAMAGE = 2.0

var is_weapon_going_down = true
var is_hitting = false
var time_since_action = 0.0
var is_bend = false
var bucket_full = false

var water = null

var effect_nodes = {}

var current_effects = []

# Called when the node enters the scene tree for the first time.
func _ready():
	# initiate weapon hit count storage
	for wtype in weapon_data:
		weapon_hit_count[wtype] = 0
		
	weapon_nodes = {
			"sword": $knight_attack/weapon/sword,
			"axe": $knight_attack/weapon/axe,
			"bucket": $knight_attack/weapon/bucket
		}
	
	water = $knight_attack/water
	water.visible = false
		
	effect_nodes = {
			"fire": $knight_attack/effects/fire
		}
	replace_weapon("sword")

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
	if attacking and not is_bend:
		if is_weapon_going_down:
			if can_replace_weapon() and next_weapon != "":
				replace_weapon(next_weapon)
				next_weapon = ""
				emit_signal("weapon_changed")
			if time_since_action >= attack_time:
				do_attack()
			else:
				time_since_action += delta
		else:
			if time_since_action >= cooldown_time:
				do_weapon_reset()
			else:
				time_since_action += delta
	
	var finished_effects = []
	for effect in current_effects:
		var damage = effect["dps"] * delta
		take_damage(damage)
		effect["time"] += delta
		if effect["time"] >= effect["max_time"]:
			effect_nodes[effect["name"]].stop()
			effect_nodes[effect["name"]].visible = false
			finished_effects.append(effect)
	for e in finished_effects:
		current_effects.remove(current_effects.find(e))
	

func do_attack():
	if weapon_type == "bucket" and bucket_full:
		stop_effect("fire")
	$AnimationPlayer.play("hit")
	time_since_action = 0.0
	is_weapon_going_down = false
	is_hitting = true
	weapon_hit_count[weapon_type] += 1
	emit_signal("weapon_damaged", weapon_type)
	# TODO: Update weapon state
	
func take_damage(damage):
	if hitpoints > 0:
		print("Knight took ", damage, " damage; hp is ", hitpoints)
		hitpoints -= damage
		$AnimationPlayer.play("damage")
		emit_signal("hitpoints_changed", hitpoints, total_hitpoints)
		if hitpoints <= 0:
			hitpoints = 0
			attacking = false
			drop_dead()

func take_tail_damage(damage):
	if hitpoints > 0 and not is_bend:
		take_damage(damage)

func on_victory():
	attacking = false
	$AnimationPlayer.play("victory")

func _on_hit():
	var damage = calc_damage()
	print("Knight deals damage: ", damage, "; cooldown: ", cooldown_time, " sec")
	emit_signal("damage_done", damage)

func do_weapon_reset():
	if attacking:
		$AnimationPlayer.play("weapon_reset")
	is_weapon_going_down = true
	time_since_action = 0.0
	
func replace_weapon(new_weapon_type):
	if weapon_type != new_weapon_type:
		for node_name in weapon_nodes:
			weapon_nodes[node_name].visible = (node_name == new_weapon_type)
		weapon_type = new_weapon_type
		attack_time = weapon_data[weapon_type]["attack_time"]
		cooldown_time = weapon_data[weapon_type]["cooldown_time"]
		if weapon_type == "bucket":
			bucket_full = true
			water.visible = true
		
func set_next_weapon(new_weapon_type):
	next_weapon = new_weapon_type

func can_replace_weapon():
	return is_weapon_going_down and not is_hitting

func _on_animation_finished(anim_name):
	if anim_name == "hit" or anim_name == "damage":
		is_hitting = false
		water.visible = false
	elif anim_name == "victory":
		emit_signal("victory")
	is_bend = false
	is_hitting = false
	if anim_name in ["hit", "bend", "victory", "damage"]:
		do_weapon_reset()

func update_weapon_hits(weapon, amount):
	weapon_hit_count[weapon] = round(len(weapon_data[weapon]["penalty"]) * (1.0 - amount))
	if amount >= 1.0:
		emit_signal("weapon_repaired", weapon)

func prepare_for_battle():
	hitpoints = total_hitpoints
	weapon_type = ""
	replace_weapon("sword")
	for weapon_name in weapon_hit_count:
		weapon_hit_count[weapon_name] = 0
	next_weapon = ""
	is_weapon_going_down = true
	is_hitting = false
	is_bend = false
	time_since_action = 0.0
	effect_nodes["fire"].visible = false
	$AnimationPlayer.play("idle")
	$AnimationPlayer.seek(0.2, true)
	$AnimationPlayer.stop()

func _find_current_effect(effect_name):
	for effect in current_effects:
		if effect["name"] == effect_name:
			return effect
	return null

func run_effect(effect_name):
	var eff_node = effect_nodes[effect_name]
	var existing_effect = _find_current_effect(effect_name)
	if existing_effect:
		existing_effect["time"] = 0.0
	else:
		eff_node.visible = true
		eff_node.run_animation()
		var new_effect = {
				"name": effect_name,
				"dps": effects_data[effect_name]["damage_per_second"],
				"time": 0.0,
				"max_time": effects_data[effect_name]["length"],
			}
		current_effects.append(new_effect)
	
func stop_effect(effect_name):
	var effects_to_stop = []
	for eff in current_effects:
		if eff["name"] == effect_name:
			effects_to_stop.append(eff)
	effect_nodes[effect_name].stop()
	effect_nodes[effect_name].visible = false
	for eff in effects_to_stop:
		current_effects.remove(current_effects.find(eff))

func do_bend():
	is_bend = true
	for wpn in weapon_nodes:
		weapon_nodes[wpn].visible = false
	$AnimationPlayer.play("bend")

func drop_dead():
	$AnimationPlayer.play("death")

func _death_completed():
	emit_signal("game_over")
