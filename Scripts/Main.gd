extends CanvasLayer

var held_object = null

# Called when the node enters the scene tree for the first time.
func _ready():
	for node in get_tree().get_nodes_in_group("draggables"):
		node.connect("clicked", _on_draggable_clicked)

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
	
	var coal_pile = get_node("Coal Pile")
	coal_pile.controller = swap(coal_pile.controller)

func swap(num: int):
	if num == 0:
		return 1
	elif num == 1:
		return 0
	
func _on_draggable_clicked(object):
	if !held_object:
		held_object = object
		held_object.pickup()
		
func _unhandled_input(event):
	if event is InputEventMouseButton and event.is_action("joy0_select"):
		if held_object and !event.pressed:
			held_object.drop(Input.get_last_mouse_velocity())
			held_object = null

func _on_coal_pile_new_coal_made(coal):
	coal.connect("clicked", _on_draggable_clicked)
	if held_object:
		held_object.drop()
	held_object = coal
	coal.pickup()
	
