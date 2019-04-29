extends Node

export var weapons = {
		"sword": {
				"min_damage": 30,
				"max_damage": 35,
				"attack_time": 0.05,
				"cooldown_time": 1.5,
				"repair_time": 2,
				"penalty": [0, 0, 2, 2, 4, 6, 8, 12, 15, 20, 26, 30]
			},
		"axe": {
				"min_damage": 60,
				"max_damage": 85,
				"attack_time": 0.05,
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
				"hitpoints": 500,
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
				"hitpoints": 600,
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
						"probability": 2,
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
				"hitpoints": 800,
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
						"probability": 3,
						"effect": "tail"
					}
				],
				"music": "enemy3.ogg",
				"weapons_avail": ["sword", "axe", "bucket"],
				"actions_avail": ["give", "repair", "drop"],
				"dialog": ["Это ещё\nчто?", "!"]
			},
		"dragon": {
				"title": "Elder Ninja Dragon",
				"hitpoints": 1500,
				"attacks": [
					{
						"type": "tail",
						"min_damage": 25,
						"max_damage": 40,
						"cooldown_time": 5,
						"probability": 3,
						"effect": "tail"
					},
					{
						"type": "fire",
						"min_damage": 5,
						"max_damage": 10,
						"cooldown_time": 5,
						"probability": 3,
						"effect": "fire"
					}
				],
				"music": "enemy1.ogg",
				"weapons_avail": ["sword", "axe", "bucket"],
				"actions_avail": ["give", "repair", "drop"],
				"dialog": ["АВЕ\nМАРИЯ", "ДЕУС\nВУЛЬТ"]
			}
	}
	
export var effects = {
		"fire": {
				"damage_per_second": 6,
				"length": 25,
			}
	}