extends RigidBody2D

signal clicked

const click_radius = 32
var held: bool = false
var in_furnace: bool = false
	
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
#		if event.pressed and event.is_action("joy0_select"):
		if event.pressed and event.is_action("joy0_select"):
			emit_signal("clicked", self)

func _process(delta):
	if held and in_furnace:
		pass
#		send signal
#		delete self

func _physics_process(delta):
	if held:
		global_transform.origin = get_global_mouse_position()

func pickup():
	if held:
		return
	freeze = true
	held = true
	
func drop(impulse=Vector2.ZERO):
	if held:
		freeze = false
		apply_central_impulse(impulse)
		held = false
