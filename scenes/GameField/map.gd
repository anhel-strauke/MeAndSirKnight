extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.

func _ready():
	match singletone.bos:
		1:
			 $X.visible=true;
			 $X2.visible=false;
			 $X3.visible=false;
		2: 
			 $X.visible=false;
			 $X2.visible=true;
			 $X3.visible=false;
		3:
			 $X.visible=false;
			 $X2.visible=false;
			 $X3.visible=true;
	pass 
	
	# Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
