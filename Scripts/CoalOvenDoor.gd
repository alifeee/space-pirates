extends Area2D

@export var door_timer: Timer

const OPEN_HEIGHT = -150
const CLOSED_HEIGHT = 0

const MIDDLE_OF_DOOR_OFFSET = 100

var opening = false
var closing = false

var open = false
var locked = false
const MOVE_SPEED = 1000

var mouse_over_door = false
var dragging = false

signal door_closed

var initial_y_position: int

@onready var flameon_sound = $"../Flame on"

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_y_position = position.y

func get_controller():
	return $"..".controller

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if opening:
		var open_position = initial_y_position + OPEN_HEIGHT
		position.y = move_toward(position.y, open_position, delta * MOVE_SPEED)
		if position.y == open_position:
			opening = false
			open_door()
	if closing:
		var closed_position = initial_y_position + CLOSED_HEIGHT
		position.y = move_toward(position.y, closed_position, delta * MOVE_SPEED)
		if position.y == closed_position:
			closing = false
			close_door()

func toggle_door():
	if locked:
		return
	if open:
		opening = false
		closing = true
	else:
		opening = true
		closing = false

func open_door():
	if locked:
		return
	position.y = initial_y_position + OPEN_HEIGHT
	open = true
func close_door():
	position.y = initial_y_position + CLOSED_HEIGHT
	open = false
	if $"..".num_coals_in_oven() > 0:
		locked = true
		$AnimatedSprite2D.play()
		flameon_sound.play()
	door_closed.emit()

func start_steering():
	dragging = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func stop_steering():
	dragging = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_viewport().warp_mouse(position + Vector2.DOWN * MIDDLE_OF_DOOR_OFFSET)
	if position.y < initial_y_position + OPEN_HEIGHT * 0.1:
		open_door()
	else:
		close_door()

func _input(event):
	if get_controller() == 1:
		if event.is_action_pressed("player1_action2"):
			toggle_door()
		
	if get_controller() == 0:
		if event.is_action("joy0_select"):
			if locked:
				return
			if (event.position - self.position).length() and mouse_over_door:
				if not dragging and event.pressed:
					start_steering()
			if dragging and not event.pressed:
				stop_steering()

		if event is InputEventMouseMotion and dragging:
			if locked:
				return
			var yamount = event.relative.y
			translate(Vector2.DOWN * yamount)
			position.y = clamp(position.y, initial_y_position + OPEN_HEIGHT, initial_y_position + CLOSED_HEIGHT)
	
func _on_mouse_entered():
	mouse_over_door = true
func _on_mouse_exited():
	mouse_over_door = false


func _on_animated_sprite_2d_animation_finished():
	locked = false
