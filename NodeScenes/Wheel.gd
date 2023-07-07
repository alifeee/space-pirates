extends Sprite2D

var elapsed_reset = 0
var elapsed_go = 0

const ROTATION_MAX = PI * 0.8
const CONTROL_SPEED = PI * 5
const RESET_SPEED = PI * 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var joy_amount = Input.get_axis("joy0_left", "joy0_right")
	
	if joy_amount == 0:
		if rotation > 0:
			rotation = move_toward(rotation, 0, RESET_SPEED * delta)
		elif rotation < 0:
			rotation = move_toward(rotation, 0, RESET_SPEED * delta)
	else: #joystick engaged
		rotation = move_toward(rotation, joy_amount * ROTATION_MAX, CONTROL_SPEED * delta)
			
	pass
