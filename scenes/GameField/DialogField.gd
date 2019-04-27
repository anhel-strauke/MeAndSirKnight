extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	_startPrint("hello world")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
var bollPrint= false; 
var textToOut=""
var numb =0 ;
var timeToPrint=0;
var maxTime=0.2; 


func _stopPrint () :
	pass
func _startPrint(var text):
	
	 bollPrint = true; 
	 textToOut= text;
	 numb= 0 ;
	 timeToPrint = 0 ;
	 $dialogSprite/Label.text = "";
	
	
func _process(delta):
	timeToPrint= timeToPrint+delta;
	if (numb==textToOut.length()):
		bollPrint = false
	
	if (timeToPrint>=maxTime&&bollPrint):
		timeToPrint=0;
		$dialogSprite/Label.text = $dialogSprite/Label.text + textToOut[numb]
		numb+=1;
		
		
	pass
