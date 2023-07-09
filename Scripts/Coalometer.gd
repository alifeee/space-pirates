extends AnimatedSprite2D

const THRESHOLDS: Array[float] = [3,6,9,12,15,18]

@export var ship: CharacterBody2D

func coal():
	return ship.coal_count

func _process(delta):
	var frame_num = 0
	var num_coal = coal()
	for threshold in THRESHOLDS:
		if num_coal > threshold:
			frame_num += 1
	frame = frame_num
