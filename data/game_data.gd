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
				"actions_avail": ["give", "repair"],
				"dialog": [ "Вперёд,\nсэр!", "!"]
			},
		"phoenix": {
				"title": "Evil Fire Bird",
				"hitpoints": 400,
				"attacks": [
					{
						"type": "hit",
						"min_damage": 7,
						"max_damage": 12,
						"cooldown_time": 3,
						"probability": 4,
						"effect": ""
					},
					{
						"type": "firewall",
						"min_damage": 0,
						"max_damage": 0,
						"cooldown_time": 4,
						"probability": 1,
						"effect": "fire"
					}
				],
				"music": "enemy2.ogg",
				"weapons_avail": ["sword", "axe", "bucket"],
				"actions_avail": ["give", "repair"],
				"dialog": ["Убъём их\nпоскорее", "!"]
			},
		"scorpion": {
				"title": "Evil Scorpion",
				"hitpoints": 500,
				"attacks": [
					{
						"type": "hit",
						"min_damage": 10,
						"max_damage": 18,
						"cooldown_time": 2.5,
						"probability": 4,
						"effect": ""
					},
					{
						"type": "tail",
						"min_damage": 25,
						"max_damage": 35,
						"cooldown_time": 5,
						"probability": 1,
						"effect": "tail"
					}
				],
				"music": "enemy3.ogg",
				"weapons_avail": ["sword", "axe", "bucket"],
				"actions_avail": ["give", "repair", "drop"],
				"dialog": ["Это ещё\nчто?", "!"]
			}
	}
	
export var effects = {
		"fire": {
				"damage_per_second": 10,
				"length": 1.5,
			}
	}