extends CharacterBody2D

@export var max_move_speed = 400.0
@export var rotation_speed = 1.5
@export var coal_increase_amount = 1
@export var coal_burn_rate = 2
@export var acceleration = 0.5
@export var deceleration = 0.5

@onready var _ship_wheel = $"../../Ship Inside/Wheel"
@onready var _animated_sprite = $AnimatedSprite2D

var shipIsDead = false
var move_speed = 0
var coal_count = 0
var rotation_direction = 0

var collider

func get_input():
	if(shipIsDead):
		return

	rotation_direction = _ship_wheel.rotation
	print(rotation_direction)
	if(Input.is_action_just_pressed("add_coal")):
		increase_coal(coal_increase_amount)

func _process(_delta):
	get_input()

func _physics_process(delta):
	if(shipIsDead):
		velocity = Vector2(0,0)
		return
	if(coal_count > 0):
		move_speed = move_toward(move_speed, max_move_speed, acceleration)
		move_speed = clamp(move_speed, 0, max_move_speed)
		velocity = -transform.y * move_speed
		coal_count -= coal_burn_rate * delta
	else:
		move_speed = move_toward(move_speed, 0, deceleration)
		move_speed = clamp(move_speed, 0, max_move_speed)
		velocity = -transform.y * move_speed
		coal_count = 0
	
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()
	checkCollisions()


func increase_coal(coalAmount):
	coal_count += coalAmount

func kills_ship():
	if(shipIsDead):
		return
	shipIsDead = true
	_animated_sprite.play("ShipDeath")
	coal_count = 0

func checkCollisions():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider.is_in_group("Asteroid"):
			print("I collided with ", collider.name)
			kills_ship()


func _on_coal_oven_coal_filled():
	increase_coal(1000)
	pass # Replace with function body.
