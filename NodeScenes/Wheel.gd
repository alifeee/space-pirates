extends Sprite2D

var elapsed_reset = 0
var elapsed_go = 0

const ROTATION_MAX = PI * 0.8
const CONTROL_SPEED = PI * 5
const RESET_SPEED = PI * 1

@export var controller: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if controller == 0:
		var joy_amount = Input.get_axis("player0_left", "player0_right")
	
		var speed
		if joy_amount == 0:
			speed = RESET_SPEED
		else: #joystick engaged
			speed = CONTROL_SPEED
			
		rotation = move_toward(rotation, joy_amount * ROTATION_MAX, speed * delta)
	elif controller == 1:
		var direction = Input.get_axis("player1_action1", "player1_action2")
		
		if direction == 1:
			rotation = move_toward(rotation, ROTATION_MAX, CONTROL_SPEED * delta)
		elif direction == -1:
			rotation = move_toward(rotation, -ROTATION_MAX, CONTROL_SPEED * delta)
