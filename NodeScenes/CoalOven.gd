extends Area2D

@export var coals: Array[Node2D] = []

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
		remove_all_coal_from_oven()
		
func add_coal_to_oven():
	for coal in coals:
		print(coal.visible)
		if not coal.visible:
			coal.visible = true
			break

func remove_all_coal_from_oven():
	for coal in coals:
		coal.visible = false



