extends Area2D

@export var door_timer: Timer

const OPEN_HEIGHT = -150
const CLOSED_HEIGHT = 0

const MIDDLE_OF_DOOR_OFFSET = 100

var open = false
var locked = false

var mouse_over_door = false
var dragging = false

signal door_closed

var initial_y_position: int

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_y_position = position.y

func get_controller():
	return $"..".controller

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func toggle_door():
	if open:
		close_door()
	else:
		open_door()

func open_door():
	if locked:
		return
	position.y = initial_y_position + OPEN_HEIGHT
	open = true
func close_door():
	position.y = initial_y_position + CLOSED_HEIGHT
	door_closed.emit()
	open = false
	locked = true
	$AnimatedSprite2D.play()
	door_timer.start()

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


func _on_animated_sprite_2d_animation_looped():
	locked = false
	$"AnimatedSprite2D".stop()
	
func _on_mouse_entered():
	mouse_over_door = true
func _on_mouse_exited():
	mouse_over_door = false
