extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var enemy_data = preload("res://data/game_data.gd").new().enemies

var knight = null
var squire = null
var knight_text = null
var squire_text = null

export var current_enemy = "enemy_1"

signal damage_done(damage)
signal begin_battle()

# Called when the node enters the scene tree for the first time.
func _ready():
	knight = $background/characters/knight
	squire = $background/characters/Me
	knight_text = $background/characters/bubble_knight/text
	squire_text = $background/characters/bubble_squire/text
	prepare_battle()

func process_weapon_click(action, weapon):
	match action:
		"give":
			if weapon != knight.weapon_type and weapon != knight.next_weapon:
				squire.do_give(weapon)
				knight.set_next_weapon(weapon)
				$GamePanel.set_current_weapon(weapon)
				$GamePanel.play_small_cooldown(action)
		"repair":
			squire.do_repair(weapon)
		"drop":
			if weapon != knight.weapon_type and weapon != knight.next_weapon:
				knight.set_next_weapon(weapon)
				knight.do_bend()
				$GamePanel.set_current_weapon(weapon)
				$GamePanel.play_small_cooldown(action)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func prepare_battle():
	var curr_enemy_data = enemy_data[current_enemy]
	$GamePanel.set_weapons_and_actions(curr_enemy_data["weapons_avail"], curr_enemy_data["actions_avail"])
	$GamePanel.set_hero_hp(1, 1)
	$GamePanel.set_enemy_hp(1, 1)
	knight.prepare_for_battle()
	squire.prepare_for_battle()
	knight.attacking = false
	var music_res_name = "res://sound/music/" + curr_enemy_data["music"]
	var resource = load(music_res_name)
	squire_text.text = curr_enemy_data["dialog"][0]
	knight_text.text = curr_enemy_data["dialog"][1]
	$music_player.stream = resource
	$music_player.play()
	
	

func _on_Me_repair_start(max_cooldown_progress):
	$GamePanel.begin_cooldown("repair", max_cooldown_progress)


func _on_Me_repair_going(progress):
	$GamePanel.update_cooldown("repair", progress)


func _on_knight_victory():
	pass # Replace with function body.


func transfer_damage_to_enemy(damage):
	emit_signal("damage_done", damage)


func transfer_damage_to_knight(damage):
	knight.take_damage(damage)

func transfer_effect_to_knight(effect):
	knight.run_effect(effect)
	
func transfer_tail_damage_to_knight(damage):
	knight.take_tail_damage(damage)

func update_enemy_hits_bar(hp, maxhp):
	print("Enemy: ", hp, " of ", maxhp)
	$GamePanel.set_enemy_hp(hp, maxhp)


func enemy_defeated():
	knight.on_victory()

func begin_level(anim):
	$AnimationPlayer.play("dialog")
	
func start_battle(anim):
	if anim == "dialog":
		knight.attacking = true
		emit_signal("begin_battle")