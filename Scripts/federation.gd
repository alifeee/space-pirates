extends Area2D

@export var MOVE_SPEED = 100
@export var MOVE_DIRECTION = Vector2(0,1)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(MOVE_DIRECTION * delta * MOVE_SPEED)

func _on_body_entered(body):
	if(body.is_in_group("Player")):
		body.kills_ship()
