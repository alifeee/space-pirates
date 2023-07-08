extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("switch_player_control"):
		switch_players()

func switch_players():
	var wheel = get_node("Wheel")
	
	wheel.controller = swap(wheel.controller)
	wheel.stop_steering()
	
	var button1 = get_node("Button1")
	var button2 = get_node("Button2")
	
	button1.controller = swap(button1.controller)
	button2.controller = swap(button2.controller)
	
	var captain_icon = get_node("Captain Icon")
	var mechanic_icon = get_node("Mechanic Icon")
	
	captain_icon.swap_controller()
	mechanic_icon.swap_controller()
	

func swap(num: int):
	if num == 0:
		return 1
	elif num == 1:
		return 0
	
	
	
	
	
