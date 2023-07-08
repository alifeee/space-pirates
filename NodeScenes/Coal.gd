extends RigidBody2D

var dragging = false
var offset = Vector2()
var drag = false

var mouse_sens= 300.0

func _physics_process(delta):
	var direction: Vector2
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	if abs(direction.x) == 1 and abs(direction.y) == 1:
		direction = direction.normalized()

	var movement = mouse_sens * direction * delta
	if (movement):  
		get_viewport().warp_mouse(get_global_mouse_position()+movement) 

func _input(event):
	if event is InputEventJoypadButton:
		if event.pressed and event.button_index == 0: # Adjust button_index as per your joystick configuration
			dragging = true
			offset = get_viewport().get_mouse_position() - position
		elif !event.pressed and event.button_index == 0: # Adjust button_index as per your joystick configuration
			dragging = false
			
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			dragging = true
			offset = event.position - position
		elif !event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			dragging = false

	if event is InputEventMouseMotion and dragging:
		set_position(get_viewport().get_mouse_position() - offset)

	if event is InputEventJoypadMotion and dragging:
		set_position(get_viewport().get_mouse_position() - offset)
