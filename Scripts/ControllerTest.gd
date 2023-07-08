extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func _init():
	Input.connect("joy_connection_changed", _joy_connection_changed)
	pass
		
func _joy_connection_changed(id, connected):
	if connected:
		print(str(id)+"connected")
	else:
		print(str(id)+"disconnected")

func _input(event):
	var device = event.device
	var text = event.as_text()
	print(str(device) + ": " + text)
