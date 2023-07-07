extends Sprite2D

var elapsed_reset = 0
var elapsed_go = 0

const ROTATION_MAX = PI * 0.8
const CONTROL_SPEED = PI / 10
const RESET_SPEED = PI / 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var joy_amount = Input.get_axis("joy0_left", "joy0_right")
	
	var speed	
	if joy_amount == 0:
		speed = RESET_SPEED
		elapsed_go = 0
	else:
		speed = CONTROL_SPEED
		elapsed_reset = 0
		
	var start = rotation
	var end = joy_amount * ROTATION_MAX
	var weight = (elapsed_go + elapsed_reset) * speed
	rotation = lerp_angle(start, end, weight)
	
	if start - end < 0.01:
		elapsed_go = 0
		elapsed_reset = 0
	
	elapsed_go += delta
	elapsed_reset += delta
	
	pass
