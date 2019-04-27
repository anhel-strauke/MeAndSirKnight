extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
const gamedata  = 'user://gamedata.save'

var login = "hello"

var fs = File.new()

func save():
	fs.open(gamedata,File.WRITE)
	fs.store_string('{"login" : "'  + login + '" }' )
	fs.close()



