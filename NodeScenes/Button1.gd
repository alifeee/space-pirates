extends Sprite2D

const LIGHT_TIME_FRAMES = 10
var countdown = 0

const DEFAULT_FRAME = 1
const PRESSED_FRAME = 0

@export var PLAYER1_ACTION: String = "joy1_action1"
@export var PLAYER2_ACTION: String = "joy0_left"
@export var controller: int = 1

const JOY_THRESHOLD = 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if controller == 1:
		var pressed = Input.get_action_raw_strength(PLAYER1_ACTION)
		if pressed:
			self.frame = PRESSED_FRAME
		else:
			self.frame = DEFAULT_FRAME
	elif controller == 0:
		var joy_amount = Input.get_action_strength(PLAYER2_ACTION)
		if joy_amount > JOY_THRESHOLD:
			self.frame = PRESSED_FRAME
		else:
			self.frame = DEFAULT_FRAME




