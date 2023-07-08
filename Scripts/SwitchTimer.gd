extends Timer

const MIN_TIME_TO_SWITCH = 8
const MAX_TIME_TO_SWITCH = 25
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	start()

func get_random_time():
	var my_random_number = rng.randf_range(MIN_TIME_TO_SWITCH, MAX_TIME_TO_SWITCH)
	return my_random_number

func _on_timeout():
	wait_time = get_random_time()
	start()

func _input(event):
	if event.is_pressed() and event.is_action("switch_player_control") and OS.is_debug_build():
		stop()
		timeout.emit()
		
