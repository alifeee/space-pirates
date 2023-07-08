extends Area2D

@export var coals: Array[Node2D] = []
@export var door: Sprite2D
var door_open = true

signal coal_filled
var coal_fill_amount = 0

func _init():
	pass
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("player1_action1"):
		add_coal_to_oven()
	if event.is_action_pressed("player1_action2"):
		toggle_door()
		
func add_coal_to_oven():
	if not door_open:
		return
	for coal in coals:
		if not coal.visible:
			coal.visible = true
			break

func remove_all_coal_from_oven():
	coal_filled.emit()
	for coal in coals:
		coal.visible = false

func toggle_door():
	if door_open:
		close_door()
	else:
		open_door()

func open_door():
	door.position.y -= 150
	door_open = true
func close_door():
	door.position.y += 150
	remove_all_coal_from_oven()
	door_open = false
