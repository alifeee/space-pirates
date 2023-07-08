extends Area2D

@export var coal_nodes: Array[Node2D] = []
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
	if event.is_action_pressed("player1_action2"):
		add_coal_to_oven()
		
func add_coal_to_oven():
	for i in range(len(coal_nodes)):
		print(i)
		var coal = coals[i]
		var coal_node = coal_nodes[i]
		if coal.position != coal_node.position:
			coal.position = coal_node.position
			break





