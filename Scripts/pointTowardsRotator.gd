extends Node2D

@export var ship: Node2D
@export var target: Node2D
var shipPosition: Vector2
var targetPosition: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta: float) -> void:
	shipPosition = ship.position
	targetPosition = target.position
	
	# gets the angle we want to face
	var angle_to_player = shipPosition.direction_to(targetPosition).angle()
	
	# slowly changes the rotation to face the angle
	rotation = move_toward(rotation, angle_to_player, delta * 5)
