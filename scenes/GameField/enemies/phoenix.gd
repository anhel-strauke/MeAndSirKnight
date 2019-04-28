extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var enemy_data = preload("res://data/game_data.gd").new().enemies

export var enemy_type = "phoenix"

signal damage_done(damage)
signal hp_changed(hp, maxhp)
signal dying()
signal finally_dead()
signal put_effect(name)

export var attacking = false
export var hitpoints: float = 0.0
var total_hitpoints = 0.0
var attacks = {}
var attack_slots = []
var time_since_attack = 0.0
var current_cooldown = 0.0
var current_attack = ""
var is_idle = true

# Called when the node enters the scene tree for the first time.
func _ready():
	var my_data = enemy_data[enemy_type]
	for attack in my_data["attacks"]:
		for i in range(0, attack["probability"]):
			attack_slots.append(attack["type"])
		attacks[attack["type"]] = {
				"min_damage": attack["min_damage"],
				"max_damage": attack["max_damage"],
				"cooldown": attack["cooldown_time"],
				"effect": attack["effect"]
			}
	prepare_for_battle()
	do_idle()
	
func prepare_for_battle():
	var my_data = enemy_data[enemy_type]
	hitpoints = my_data["hitpoints"]
	total_hitpoints = hitpoints
	time_since_attack = 0.0
	current_cooldown = 2.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if attacking:
		if is_idle:
			time_since_attack += delta
			if time_since_attack >= current_cooldown:
				do_some_attack()
			
		

func do_idle():
	$AnimationPlayer.play("idle")
	is_idle = true
	
func do_some_attack():
	var i = rand_range(0, len(attack_slots))
	if i == len(attack_slots):
		i = 0
	var attack_type = attack_slots[i]
	print("...with ", attack_type)
	do_attack_animation(attack_type)
	current_attack = attack_type
	current_cooldown = attacks[current_attack]["cooldown"]
	is_idle = false
	
func do_attack_animation(attack_type):
	match attack_type:
		"hit":
			$AnimationPlayer.play("attack")
		"firewall":
			$AnimationPlayer.play("fire")

func _make_hit_damage():
	var dmg = rand_range(attacks[current_attack]["min_damage"], attacks[current_attack]["max_damage"])
	if dmg > 0:
		emit_signal("damage_done", dmg)
	
func _make_firewall_effect():
	var dmg = rand_range(attacks[current_attack]["min_damage"], attacks[current_attack]["max_damage"])
	if dmg > 0:
		emit_signal("damage_done", dmg)
	if attacks[current_attack]["effect"] != "":
		emit_signal("put_effect", attacks[current_attack]["effect"])

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "attack" or anim_name == "fire":
		time_since_attack = 0
		do_idle()
	elif anim_name == "death":
		emit_signal("finally_dead")

func take_damage(damage):
	print("Phoenix takes ", damage, " damage, hp = ", hitpoints)
	if hitpoints > 0:
		hitpoints -= damage
		emit_signal("hp_changed", hitpoints, total_hitpoints)
		if hitpoints <= 0:
			hitpoints = 0
			do_death()
			attacking = false
			
func do_death():
	$AnimationPlayer.play("death")
	emit_signal("dying")
