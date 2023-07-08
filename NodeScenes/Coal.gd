extends RigidBody2D

var dragging = false
var offset = Vector2()
var drag = false

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			dragging = true
			offset = event.position - position
		elif !event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			dragging = false

	if event is InputEventMouseMotion and dragging:
		set_position(get_viewport().get_mouse_position() - offset)
