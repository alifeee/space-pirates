extends CanvasLayer

var held_object = null
var swapped_roles: bool = false

@export var WinAndLoseScreen: CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	for node in get_tree().get_nodes_in_group("draggables"):
		node.connect("clicked", _on_draggable_clicked)
		
func _process(delta):
	pass

func _on_lightning_animation_finished():
	switch_players()
	
func switch_players():
	swapped_roles = !swapped_roles
	
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
	
	var coal_oven = get_node("Coal Oven")
	coal_oven.controller = swap(coal_oven.controller)

func swap(num: int):
	if num == 0:
		return 1
	elif num == 1:
		return 0
	
func _on_draggable_clicked(object):
	if !swapped_roles:
		return
		
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
	
func game_win():
	WinAndLoseScreen.showSelf(true)
	print("You Win!")
	pass

func game_lose():
	WinAndLoseScreen.showSelf(false)
	print("You LOSE!")
	pass

func _on_space_ship_ship_died():
	game_lose()

func _on_space_ship_ship_escaped():
	game_win()


