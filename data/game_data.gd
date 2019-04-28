extends Node

export var weapons = {
		"sword": {
				"min_damage": 30,
				"max_damage": 35,
				"attack_time": 0.1,
				"cooldown_time": 1.5,
				"repair_time": 2,
				"penalty": [0, 0, 2, 2, 4, 6, 8, 12, 15, 20, 26, 30]
			},
		"axe": {
				"min_damage": 60,
				"max_damage": 85,
				"attack_time": 0.1,
				"cooldown_time": 1.5,
				"repair_time": 5,
				"penalty": [0, 8, 16, 32, 48]
			},
		"bucket": {
				"min_damage": 6,
				"max_damage": 6,
				"attack_time": 0.1,
				"cooldown_time": 1.5,
				"repair_time": 0,
				"penalty": [0]
			}
	}
	
export var enemies = {
		"enemy_1": {
				"title": "Evil Knight",
				"hitpoints": 400,
				"min_damage": 5,
				"max_damage": 10,
				"cooldown_time": 2,
				"music": "enemy1.ogg",
				"weapons_avail": ["sword", "axe"],
				"actions_avail": ["give", "repair"]
			}
	}
	
export var effects = {
		"fire": {
				"damage_per_second": 10,
				"length": 1.5,
			}
	}