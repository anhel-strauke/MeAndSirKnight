extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var action_buttons= []
var weapon_buttons = [] 
signal action_clicked(name)
signal weapon_clicked(act,wep)

func onButtonClicked(var btnName):
	var action = false
	var actionName = ""
	for  x in action_buttons:
		if (x.name==btnName):
			action=true
			emit_signal("action_clicked",btnName)
			actionName=btnName
			x.set_selected(true)
		else:
			x.set_selected(false)
	if (!action):
		emit_signal("weapon_clicked",btnName,actionName)
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	action_buttons = [$UInode/we_give,$UInode/we_repair,$UInode/we_drop]
	weapon_buttons = [$UInode/we_sword,$UInode/we_axe,$UInode/we_bucket]
	action_buttons[0].set_selected(true)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
