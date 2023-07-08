extends Sprite2D

const LIGHT_TIME_FRAMES = 10
var countdown = 0

const DEFAULT_FRAME = 1
const PRESSED_FRAME = 0

@export var PRESS_ACTION: String = "joy1_action1"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	countdown -= 1
	if countdown == 0:
		self.frame = DEFAULT_FRAME
	pass

func _input(event):
	if event.is_action_pressed(PRESS_ACTION):
		light_up()
		
func light_up():
	self.frame = PRESSED_FRAME
	countdown = LIGHT_TIME_FRAMES
