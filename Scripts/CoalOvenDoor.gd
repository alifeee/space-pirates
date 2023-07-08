extends Area2D

@export var door_timer: Timer

var open = false
var locked = false

var mouse_over_door = false
var dragging = false

signal door_closed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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
	position.y -= 150
	open = true
func close_door():
	position.y += 150
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

func _input(event):
	if get_controller() != 0:
		return
	if event.is_action("joy0_select"):
		if (event.position - self.position).length() and mouse_over_door:
			if not dragging and event.pressed:
				start_steering()
		if dragging and not event.pressed:
			stop_steering()

	if event is InputEventMouseMotion and dragging:
		var yloc = get_global_mouse_position()
		print(yloc)


func _on_animated_sprite_2d_animation_looped():
	locked = false
	$"AnimatedSprite2D".stop()
	
func _on_mouse_entered():
	mouse_over_door = true
func _on_mouse_exited():
	mouse_over_door = false
