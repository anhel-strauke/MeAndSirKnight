extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var cursor: Node2D = null
var current_item = 0
var cursor_enabled = false
var menu_items = []

# Called when the node enters the scene tree for the first time.
func _ready():
	cursor = $game_menu/main_menu_cursor
	menu_items = [
		$game_menu/new_game,
		$game_menu/authors,
		$game_menu/language,
		$game_menu/exit
	]
	if OS.get_name() == "HTML5":
		var exit_item = menu_items[len(menu_items) - 1]
		exit_item.visible = false
		menu_items.remove(len(menu_items) - 1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_cursor_to_item(item: int):
	if item >= 0 and item < len(menu_items):
		cursor.set_visible(true)
		var curr_item = menu_items[item] as Label
		cursor.set_position(Vector2(cursor.position.x, curr_item.rect_position.y))
		current_item = item
	else:
		current_item = -1
		cursor.visible = false

func _on_main_animation_finished(anim_name):
	pass
		
		
func _activate_menu():
	cursor_enabled = true
	cursor.set_visible(true)
	set_cursor_to_item(0)

func _input(event):
	#if not event is InputEventMouse:
	#	print(event.as_text())
	if not cursor_enabled:
		return
	if event is InputEventMouseMotion:
		for menu_item in menu_items:
			var mouse_pos: Vector2 = menu_item.get_local_mouse_position()
			if (mouse_pos.x < menu_item.get_size().x and mouse_pos.x >= 0 and
				mouse_pos.y < menu_item.get_size().y and mouse_pos.y >= 0):
					var item_index = menu_items.find(menu_item)
					set_cursor_to_item(item_index)
					# TODO: Play sound
					break
	elif event is InputEventMouseButton:
		if event.get_button_index() == BUTTON_LEFT and event.is_pressed():
			# TODO: Play sound
			for menu_item in menu_items:
				var mouse_pos: Vector2 = menu_item.get_local_mouse_position()
				if (mouse_pos.x < menu_item.get_size().x and mouse_pos.x >= 0 and
					mouse_pos.y < menu_item.get_size().y and mouse_pos.y >= 0):
						var item_index = menu_items.find(menu_item)
						execute_action(item_index)
						break
#	elif event.is_action_pressed("ui_down"):
#		var item = current_item + 1
#		if item >= len(menu_items):
#			item = 0
#		set_cursor_to_item(item)
#		# TODO: Play sound
#	elif event.is_action_pressed("ui_up"):
#		var item = current_item - 1
#		if item < 0:
#			item = len(menu_items) - 1
#		set_cursor_to_item(item)
#		# TODO: Play sound
#	elif event.is_action_pressed("ui_accept"):
#		# TODO: Play sound
#		execute_action(current_item)

func execute_action(menu_item: int):
	match menu_item:
		0:
			get_tree().change_scene("res://scenes/StorytellingScene.tscn")
		1:
			get_tree().change_scene("res://scenes/about_team.tscn")
		2:
			get_tree().change_scene("res://scenes/language_screen.tscn")
		3:
			get_tree().quit()

