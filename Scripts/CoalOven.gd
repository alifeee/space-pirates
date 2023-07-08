extends Area2D

@export var coals: Array[Node2D] = []
@export var door: AnimatedSprite2D
@export var door_timer: Timer

var door_open = false
var door_locked = false

signal coal_filled(amount)
var coal_fill_amount = 0

var controller: int = 1

func _init():
	pass
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var overlapping_coals = get_overlapping_bodies()
	if len(overlapping_coals) > 0:
		var first_overlapping_coal = overlapping_coals[0]
		if first_overlapping_coal.held or not door_open:
			return
		else:
			first_overlapping_coal.queue_free()
			add_coal_to_oven()

func _input(event):
	if event.is_action_pressed("player1_action1") and controller == 1:
		add_coal_to_oven()
	if event.is_action_pressed("player1_action2") and controller == 1:
		toggle_door()
		
func add_coal_to_oven():
	if not door_open:
		return
	for coal in coals:
		if not coal.visible:
			coal.visible = true
			break

func remove_all_coal_from_oven():
	var num_coals = 0
	for coal in coals:
		if coal.visible:
			num_coals += 1
		coal.visible = false
	
	coal_filled.emit(num_coals)

func toggle_door():
	if door_open:
		close_door()
	else:
		open_door()

func open_door():
	if door_locked:
		return
	door.position.y -= 150
	door_open = true
func close_door():
	door.position.y += 150
	remove_all_coal_from_oven()
	door_open = false
	door_locked = true
	door.play()
	door_timer.start()

func _on_door_animation_looped():
	door.stop()

func _on_door_timer_timeout():
	door_locked = false
