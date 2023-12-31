extends CharacterBody2D

@export var max_move_speed = 400.0
@export var rotation_speed = 1.5
@export var coal_increase_amount = 1
@export var max_coal_amount = 18
@export var coal_burn_rate = 2.0
@export var acceleration = 0.5
@export var deceleration = 0.5

@onready var _ship_wheel = $"../../Ship Inside/Wheel"
@onready var _coal_label = $"../../Ship Inside/Label"
@onready var _animated_sprite = $AnimatedSprite2D
@onready var _move_particles = $"Ship Moving Particles"
@onready var thrust_sound  = $"Thrust"

signal shipDied
signal shipEscaped

var shipIsDead = false
var move_speed = 0
var coal_count = 0
var rotation_direction = 0

var collider

func get_input():
	if(shipIsDead):
		return

	rotation_direction = _ship_wheel.rotation
	if(Input.is_action_just_pressed("add_coal")) and OS.is_debug_build():
		increase_coal(coal_increase_amount)

func _process(_delta):
	get_input()

func _physics_process(delta):
	if(shipIsDead):
		velocity = Vector2(0,0)
		return
	if(coal_count > 0):
		_move_particles.visible = true
		if not thrust_sound.playing:
			thrust_sound.play()
		move_speed = move_toward(move_speed, max_move_speed, acceleration)
		move_speed = clamp(move_speed, 0, max_move_speed)
		velocity = -transform.y * move_speed
		decrease_coal(coal_burn_rate * delta)
	else:
		_move_particles.visible = false
		if thrust_sound.playing:
			thrust_sound.stop()
		move_speed = move_toward(move_speed, 0, deceleration)
		move_speed = clamp(move_speed, 0, max_move_speed)
		velocity = -transform.y * move_speed
		decrease_coal(coal_burn_rate * delta)
	
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()
	checkCollisions()

func increase_coal(coalAmount):
	coal_count = min(coal_count + coalAmount, max_coal_amount)
	_coal_label.text = str(coal_count)
	
func decrease_coal(coalAmount):
	coal_count = move_toward(coal_count, 0, coalAmount)
	_coal_label.text = str(coal_count)

func kills_ship():
	if(shipIsDead):
		return
	shipIsDead = true
	_move_particles.visible = false
	_animated_sprite.play("ShipDeath")
	coal_count = 0
	shipDied.emit()
	
func ship_escaped():
	if(shipIsDead):
		return
	shipIsDead = true
	_move_particles.visible = false
	shipEscaped.emit()
	visible = false

func checkCollisions():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider.is_in_group("Asteroid"):
			print("I collided with ", collider.name)
			kills_ship()
		if collider.is_in_group("WinZone"):
			print("I WIN!!! I collided with ", collider.name)
			ship_escaped()

func _on_coal_oven_coal_filled(amount):
	increase_coal(amount)
	pass # Replace with function body.
