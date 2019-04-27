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
				"min_damage": 50,
				"max_damage": 55,
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