extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal weapon_updated(weapon, amount)
signal repair_done(weapon)
signal repair_start(max_cooldown_progress)
signal repair_going(progress)

var weapon_data = preload("res://data/game_data.gd").new().weapons

enum State {
		Idle,
		Give,
		Repair
	}

var weapons = {}
var current_weapon = ""
var state = State.Idle

var weapon_repair_time = {}
var weapon_repair_total_time = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	weapons = {
		"axe": $weapon/axe,
		"sword": $weapon/sword,
		"bucket": $weapon/bucket
	}
	for weapon_name in weapon_data:
		weapon_repair_time[weapon_name] = 0.0
		weapon_repair_total_time[weapon_name] = weapon_data[weapon_name]["repair_time"]
	do_idle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == State.Repair:
		weapon_repair_time[current_weapon] += delta
		var amount = weapon_repair_time[current_weapon] / weapon_repair_total_time[current_weapon]
		if amount > 1.0:
			amount = 1.0
		emit_signal("weapon_updated", current_weapon, amount)
		emit_signal("repair_going", weapon_repair_time[current_weapon])
		if weapon_repair_time[current_weapon] >= weapon_repair_total_time[current_weapon]:
			emit_signal("repair_done", current_weapon)
			do_idle()

func _show_weapon(weapon):
	for weapon_name in weapons:
		weapons[weapon_name].visible = (weapon == weapon_name)

func do_idle():
	state = State.Idle
	_show_weapon("")
	$Me.modulate = Color(1, 1, 1)
	$AnimationPlayer.play("idle_still")

func weapon_taken():
	do_idle()

func do_give(weapon):
	if state == State.Repair:
		emit_signal("repair_done", current_weapon)
	state = State.Give
	_show_weapon(weapon)
	current_weapon = weapon
	$Me.modulate = Color(1, 1, 1)
	$AnimationPlayer.play("idle_give")
	
func do_repair(weapon):
	if state == State.Repair:
		emit_signal("repair_done", current_weapon)
	state = State.Repair
	current_weapon = weapon
	emit_signal("repair_start", weapon_repair_total_time[current_weapon])
	_show_weapon(weapon)
	$AnimationPlayer.play("repair")
	
func prepare_for_battle():
	do_idle()
	for weapon_name in weapon_data:
		weapon_repair_time[weapon_name] = 0.0