extends CharacterBody2D

@export var speed = 400
@export var rotation_speed = 1.5

var coal_increase_amount = 10
var coal_count = 0

var rotation_direction = 0

func get_input():
	rotation_direction = Input.get_axis("left", "right")
	#velocity = -transform.y * Input.get_action_raw_strength("Go!") * speed
	if(Input.get_action_raw_strength("Go!")):
		increase_coal(coal_increase_amount)
		print(coal_count)

func _process(delta):
	get_input()

func _physics_process(delta):
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()

func increase_coal(coalAmount):
	coal_count += coalAmount
