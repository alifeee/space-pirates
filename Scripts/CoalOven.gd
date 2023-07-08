extends Area2D

@export var coals: Array[Node2D] = []
@export var door: Area2D

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
		if first_overlapping_coal.held or not door.open or is_oven_full():
			return
		else:
			first_overlapping_coal.queue_free()
			add_coal_to_oven()
			

func _input(event):
	if controller == 1:
		if event.is_action_pressed("player1_action1"):
			add_coal_to_oven()
		
func add_coal_to_oven():
	if not door.open:
		return
	for coal in coals:
		if not coal.visible:
			coal.visible = true
			break

func num_coals_in_oven():
	var num = 0
	for coal in coals:
		if coal.visible:
			num += 1
	return num
	
func is_oven_full():
	return num_coals_in_oven() >= len(coals)

func remove_all_coal_from_oven():
	for coal in coals:
		coal.visible = false
	
	coal_filled.emit(num_coals_in_oven())


func _on_door_door_closed():
	remove_all_coal_from_oven()
