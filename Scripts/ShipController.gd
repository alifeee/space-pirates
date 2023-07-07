extends CharacterBody2D

@export var max_move_speed = 400.0
@export var rotation_speed = 1.5
@export var coal_increase_amount = 1
@export var coal_burn_rate = 2
@export var acceleration = 0.5
@export var deceleration = 0.5

var move_speed = 0
var coal_count = 0
var rotation_direction = 0

func get_input():
	rotation_direction = Input.get_axis("left", "right")
	#velocity = -transform.y * Input.get_action_raw_strength("Go!") * move_speed
	if(Input.is_action_just_pressed("add_coal")):
		increase_coal(coal_increase_amount)

func _process(delta):
	get_input()

func _physics_process(delta):
	if(coal_count > 0):
		move_speed = move_toward(move_speed, max_move_speed, acceleration)
		move_speed = clamp(move_speed, 0, max_move_speed)
		velocity = -transform.y * move_speed
		coal_count -= coal_burn_rate * delta
	else:
		move_speed = move_toward(move_speed, 0, deceleration)
		move_speed = clamp(move_speed, 0, max_move_speed)
		velocity = -transform.y * move_speed
		coal_count = 0;
	
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()

func increase_coal(coalAmount):
	coal_count += coalAmount
