extends Node2D

@export var spinSpeed = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	spinSpeed = spinSpeed * randf_range(0, 3) * randf_range(-1, 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate(spinSpeed * delta)

