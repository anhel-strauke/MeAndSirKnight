extends Node2D

var action_buttons = []
var weapon_buttons = [] 
signal action_clicked(name)
signal weapon_clicked(act, wep)

var hero_hp_bar = null
var enemy_hp_bar = null
var status_label = null

var current_action = "give"
var current_weapon = "sword"
var current_knight_weapon = "sword"

var damaged_weapons = []
var can_do_actions = true

# Public interface

func set_weapons_and_actions(weapons, actions):
	for weapon_button in weapon_buttons:
		weapon_button.visible = weapon_button.item_name in weapons
	for act_button in action_buttons:
		act_button.visible = act_button.item_name in actions

func set_hero_hp(hp, max_hp):
	hero_hp_bar.set_progress(hp / max_hp)
	
func set_enemy_hp(hp, max_hp):
	enemy_hp_bar.set_progress(hp/ max_hp)
	
func begin_cooldown(action, max_progress):
	for act_button in action_buttons:
		if act_button.item_name == action:
			act_button.play_cooldown(max_progress)
			return
	
func update_cooldown(action, progress):
	for act_button in action_buttons:
		if act_button.item_name == action:
			act_button.update_cooldown(progress)
			return
	
func end_cooldown(action):
	for act_button in action_buttons:
		if act_button.item_name == action:
			act_button.end_cooldown()
			return
			
func play_small_cooldown(action):
	for act_button in action_buttons:
		if act_button.item_name == action:
			act_button.play_small_cooldown()
			return
var activeState = true
# Internals
func setEnabled():
	can_do_actions= true
	
func setDisabled():
	can_do_actions = false
	
func onButtonClicked(var btnName):
	if not can_do_actions:
		return
	for act_button in action_buttons:
		if act_button.item_name == btnName:
			emit_signal("action_clicked", btnName)
			set_current_action(btnName)
			return
	for wpn_button in weapon_buttons:
		if wpn_button.item_name == btnName:
			emit_signal("weapon_clicked", current_action, btnName)
			set_current_action("give")

func set_current_action(action):
	for act_button in action_buttons:
		act_button.set_selected(act_button.item_name == action)
	current_action = action
	if current_action == "repair":
		update_repairable_weapons()
	else:
		restore_weapon_buttons()
		
func set_current_weapon(weapon):
	for weapon_button in weapon_buttons:
		weapon_button.set_selected(weapon_button.item_name == weapon)
	current_weapon = weapon
	
func update_knight_weapon():
	current_knight_weapon = current_weapon
	if current_action == "repair":
		update_repairable_weapons()
		
func restore_weapon_buttons():
	for weapon_button in weapon_buttons:
		weapon_button.set_dimmed(false)

func update_repairable_weapons():
	for weapon_button in weapon_buttons:
		var current = (current_weapon == weapon_button.item_name)
		var kn_current = (current_knight_weapon == weapon_button.item_name)
		var damaged = (weapon_button.item_name in damaged_weapons)
		weapon_button.set_dimmed(not damaged or current or kn_current)

# Called when the node enters the scene tree for the first time.
func _ready():
	action_buttons = [
		$game_panel/UInode/we_give,
		$game_panel/UInode/we_repair,
		$game_panel/UInode/we_drop
	]
	weapon_buttons = [
		$game_panel/UInode/we_sword,
		$game_panel/UInode/we_axe,
		$game_panel/UInode/we_bucket
	]
	hero_hp_bar = $game_panel/UInode/hero_hits_bar
	enemy_hp_bar = $game_panel/UInode/enemy_hits_bar
	status_label = $game_panel/UInode/status_label
	set_current_action("give")
	set_current_weapon("sword")

func _input(event):
	if event is InputEventMouseMotion:
		for button in action_buttons + weapon_buttons:
			if button.is_mouse_over():
				set_hint(button.name)
				return
		status_label.text = ""

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func mark_weapon_damaged(weapon):
	if not weapon in damaged_weapons:
		damaged_weapons.append(weapon)
		
func mark_weapon_repaired(weapon):
	if weapon in damaged_weapons:
		damaged_weapons.remove(damaged_weapons.find(weapon))
		
func mark_bisy():
	can_do_actions = false
	
func mark_ready():
	can_do_actions = true

func set_hint(button_id):
	match button_id:
		"we_give":
			status_label.text = "Подать оружие"
		"we_repair":
			status_label.text = "Чинить оружие"
		"we_drop":
			status_label.text = "Бросить оружие"
		"we_sword":
			status_label.text = "Меч"
		"we_axe":
			status_label.text = "Секира"
		"we_bucket":
			status_label.text = "Ведро с водой"
