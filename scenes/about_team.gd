extends Node2D

var can_click = false

const about_text = {
		"ru": """[color=#fea711]And Tak Soidet Games[/color]

[color=#cce1ae]Гейм-дизайн:[/color]
    Дина
	
[color=#cce1ae]Код:[/color]
    Анхель
	Артур
	
[color=#cce1ae]Графика:[/color]
    Ника
	Эвелина
	
[color=#cce1ae]Анимации, персонажи:[/color]
    Мэвен
	
[color=#cce1ae]Музыка/FX:[/color]
    Ди""",
	
		"en": """[color=#fea711]And Tak Soidet Games[/color]

[color=#cce1ae]Game Design:[/color]
    Dina
	
[color=#cce1ae]Code:[/color]
    Anhel
	Arthur
	
[color=#cce1ae]Graphics:[/color]
    Nika
	Evelina
	
[color=#cce1ae]Animations, characters:[/color]
    Meven
	
[color=#cce1ae]Music/FX:[/color]
    Di"""
	}

# Called when the node enters the scene tree for the first time.
func _ready():
	var locale = TranslationServer.get_locale()
	if not locale in about_text:
		locale = "en"
	$Label.bbcode_text = about_text[locale]
	
func ret():
	get_tree().change_scene("res://scenes/MainMenu.tscn")
	

func enable_click():
	can_click = true

func _input(event):
	if can_click:
		if event is InputEventMouseButton:
			if event.pressed:
				ret()