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
var attack_queue = []
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
	print("--- Battle with ", enemy_type, " -----------------------")
	
func prepare_for_battle():
	var my_data = enemy_data[enemy_type]
	hitpoints = my_data["hitpoints"]
	total_hitpoints = hitpoints
	time_since_attack = 0.0
	current_cooldown = 0.5
	attacking = false
	attack_queue = my_data["attack_queue"]

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
	
func build_attack_queue():
	attack_queue = []
	var attacks_list = []
	for attack in attack_slots:
		attacks_list.append(attack)
	var q = ""
	while len(attacks_list) > 0:
		var attack_index = randi() % len(attacks_list)
		attack_queue.append(attacks_list[attack_index])
		q += attacks_list[attack_index] + " "
		attacks_list.remove(attack_index)
	print("*** ", enemy_type, " queue: ", q)
	
func do_some_attack():
	if len(attack_queue) == 0:
		build_attack_queue()
	var attack_type = attack_queue[0]
	attack_queue.remove(0)
	do_attack_animation(attack_type)
	print("* ", enemy_type, " do ", attack_type)
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
	print(enemy_type, " takes ", damage, " damage, hp was ", hitpoints)
	if hitpoints > 0:
		$damage_emitter.add_point(damage)
		hitpoints -= damage
		emit_signal("hp_changed", hitpoints, total_hitpoints)
		if hitpoints <= 0:
			hitpoints = 0
			do_death()
			attacking = false
			
func do_death():
	$AnimationPlayer.play("death")
	emit_signal("dying")

func begin_battle():
	attacking = true
