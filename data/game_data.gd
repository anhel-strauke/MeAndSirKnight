extends Node

var knight = {
		"hitpoints": 260,
	}

var weapons = {
		"sword": {
				"min_damage": 30,
				"max_damage": 45,
				"attack_time": 0.05,
				"cooldown_time": 1.0,
				"repair_time": 2,
				"penalty": [0, 0, 2, 2, 4, 6, 8, 12, 15, 20, 26, 30]
			},
		"axe": {
				"min_damage": 70,
				"max_damage": 95,
				"attack_time": 0.05,
				"cooldown_time": 2.5,
				"repair_time": 4,
				"penalty": [-30, 0, 0, 16, 48, 54, 72]
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
	
var enemies = {
		"enemy_1": {
				"title": "Evil Knight",
				"hitpoints": 500,
				"min_damage": 5,
				"max_damage": 10,
				"cooldown_time": 2,
				"music": "enemy1.ogg",
				"music_volume": -11.107,
				"weapons_avail": ["sword", "axe"],
				"actions_avail": ["give", "repair"],
				"dialog": [ tr("ENEMY_1_PHRASE_1"), tr("ENEMY_1_PHRASE_2")]
			},
		"phoenix": {
				"title": "Evil Fire Bird",
				"hitpoints": 700,
				"attacks": [
					{
						"type": "hit",
						"min_damage": 7,
						"max_damage": 12,
						"cooldown_time": 1.7,
						"probability": 5,
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
				"attack_queue": ["hit", "firewall", "hit"],
				"music": "enemy2.ogg",
				"music_volume": 0.0,
				"weapons_avail": ["sword", "axe", "bucket"],
				"actions_avail": ["give", "repair"],
				"dialog": [tr("ENEMY_2_PHRASE_1"), tr("ENEMY_2_PHRASE_2")]
			},
		"scorpion": {
				"title": "Evil Scorpion",
				"hitpoints": 900,
				"attacks": [
					{
						"type": "hit",
						"min_damage": 10,
						"max_damage": 18,
						"cooldown_time": 2.0,
						"probability": 3,
						"effect": ""
					},
					{
						"type": "tail",
						"min_damage": 40,
						"max_damage": 65,
						"cooldown_time": 5,
						"probability": 1,
						"effect": "tail"
					}
				],
				"attack_queue": ["hit", "tail", "hit", "hit", "tail", "hit", "tail", "hit", "hit", "tail"],
				"music": "enemy3.ogg",
				"music_volume": -11.107,
				"weapons_avail": ["sword", "axe", "bucket"],
				"actions_avail": ["give", "repair", "drop"],
				"dialog": [tr("ENEMY_3_PHRASE_1"), tr("ENEMY_3_PHRASE_2")]
			},
		"dragon": {
				"title": "Elder Ninja Dragon",
				"hitpoints": 1400,
				"attacks": [
					{
						"type": "tail",
						"min_damage": 50,
						"max_damage": 70,
						"cooldown_time": 6,
						"probability": 3,
						"effect": "tail"
					},
					{
						"type": "fire",
						"min_damage": 2,
						"max_damage": 10,
						"cooldown_time": 5,
						"probability": 4,
						"effect": "fire"
					}
				],
				"attack_queue": ["fire", "tail", "fire", "tail", "fire"],
				"music": "enemy1.ogg",
				"music_volume": -11.107,
				"weapons_avail": ["sword", "axe", "bucket"],
				"actions_avail": ["give", "repair", "drop"],
				"dialog": [tr("ENEMY_4_PHRASE_1"), tr("ENEMY_4_PHRASE_2")]
			}
	}
	
var effects = {
		"fire": {
				"damage_per_second": 6,
				"length": 25,
			}
	}