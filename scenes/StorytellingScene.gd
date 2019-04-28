extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
#func o
var currentSpriteid = 1 

func setVisibleStory():
		if(currentSpriteid==1):
			currentSpriteid=2
			$story1.visible=false
			$story2.visible=true
			$story3.visible=false
		else: 
			currentSpriteid=3
			$story1.visible=false
			$story2.visible=false
			$story3.visible=true
		if(currentSpriteid==3):
			get_tree().change_scene("res://scenes/levels/level_1.tscn")

	

func _ready():
	pass 
	# Replace with function body.
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		setVisibleStory()
		
var tmp = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	tmp+=delta
	if(tmp>=5.0):
		setVisibleStory()
		tmp=0.0
	
