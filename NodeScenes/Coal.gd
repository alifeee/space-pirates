extends RigidBody2D

var dragging = false
var offset = Vector2()
var drag = false
var click_radius = 32
var mouse_sens= 300.0

@export var controller: int = 0
func _ready():
	self.position = Vector2(5,5) 

func _physics_process(delta):
	return
	var direction: Vector2
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	if abs(direction.x) == 1 and abs(direction.y) == 1:
		direction = direction.normalized()

	var movement = mouse_sens * direction * delta
	if (movement):  
		get_viewport().warp_mouse(get_global_mouse_position()+movement) 
		
func _process(delta):
	if controller == 0:
		return
	if controller == 1:
		if Input.is_action_just_pressed("add_coal_button"):
			var speed = 1 # Change this to increase it to more units/second
			position = position.move_toward(Vector2(0,0), delta * speed)
	
func _input(event):
	if controller == 1:
		return
	elif controller == 0:
		if event is InputEventJoypadButton:
			if event.pressed and event.button_index == 0: 
				if (get_viewport().get_mouse_position() - self.position).length() < click_radius:
					dragging = true
					offset = get_viewport().get_mouse_position() - position
			elif !event.pressed and event.button_index == 0: 
				dragging = false
				
		if event is InputEventMouseButton:
			if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
				if (event.position - self.position).length() < click_radius:
					dragging = true
					offset = event.position - position
			elif !event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
				dragging = false

		if event is InputEventMouseMotion and dragging:
			set_position(get_viewport().get_mouse_position() - offset)

		if event is InputEventJoypadMotion and dragging:
			set_position(get_viewport().get_mouse_position() - offset)
	
