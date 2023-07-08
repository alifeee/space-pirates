extends Sprite2D

var elapsed_reset = 0
var elapsed_go = 0

const ROTATION_MAX = PI * 0.8
const CONTROL_SPEED = PI * 5
const RESET_SPEED = PI * 1

@export var controller: int = 0

var steering = false
const CLICK_RADIUS = 150
const MOUSE_CONTROL_SPEED = .01

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if controller == 0:
		# controller movement
		var joy_amount = Input.get_axis("player0_left", "player0_right")
		var speed
		if joy_amount == 0:
			speed = RESET_SPEED
		else: #joystick engaged
			speed = CONTROL_SPEED
		if not steering:
			rotation = move_toward(rotation, joy_amount * ROTATION_MAX, speed * delta)
		
		# mouse movement
		# see _input
	elif controller == 1:
		var direction = Input.get_axis("player1_action1", "player1_action2")
		
		if direction == 1:
			rotation = move_toward(rotation, ROTATION_MAX, CONTROL_SPEED * delta)
		elif direction == -1:
			rotation = move_toward(rotation, -ROTATION_MAX, CONTROL_SPEED * delta)

func _input(event):
	# mouse control (player 0 only)
	if controller != 0:
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if (event.position - self.position).length() < CLICK_RADIUS:
			if not steering and event.pressed:
				steering = true
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		if steering and not event.pressed:
			steering = false
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if event is InputEventMouseMotion and steering:
		var xmove = event.relative.x
		
		if xmove > 0:
			rotation = move_toward(rotation, ROTATION_MAX, MOUSE_CONTROL_SPEED * xmove)
		elif xmove < 0:
			rotation = move_toward(rotation, -ROTATION_MAX, - MOUSE_CONTROL_SPEED * xmove)
			
#		rotation = xmoive

