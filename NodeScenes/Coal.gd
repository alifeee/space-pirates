extends RigidBody2D

var dragging = false
var drag = false
var click_radius = 32
var mouse_sens= 300.0
var isMoving: bool = false
var targetPosition: Vector2 = Vector2(671, 447)

@export var controller: int = 0

func _ready():
	pass

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
#	if controller == 1:
#		if Input.is_action_just_pressed("add_coal_button"):
#			isMoving = true
#		print("add coal button pressed")
#		if isMoving:
#			var movementSpeed = 3 
#			var direction = (targetPosition - self.position)
#			var distance = movementSpeed * delta
#			self.position += direction * distance
#
#			if self.position.distance_to(targetPosition) <= distance:
#				isMoving = false	

func start_dragging():
	dragging = true
	
func stop_dragging():
	dragging = false

func _input(event):
	if controller == 1:
		return
#	if event is InputEventJoypadButton:
#		if event.pressed and event.button_index == 0: 
#			if (get_viewport().get_mouse_position() - self.position).length() < click_radius:
#				dragging = true
#		elif !event.pressed and event.button_index == 0: 
#			dragging = false
			
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if (event.position - self.position).length() < click_radius:
				start_dragging()
		elif !event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			stop_dragging()

	if event is InputEventMouseMotion and dragging:
		self.position = event.position

#	if event is InputEventJoypadMotion and dragging:
#		self.position = event.position
