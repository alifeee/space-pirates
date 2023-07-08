extends Area2D

var mouse_in: bool = false
@export var controller: int = 1

signal new_coal_made(coal)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action("joy0_select") and event.is_pressed() and mouse_in:
		new_coal()
	pass

func new_coal():
	var new_coal = preload("res://NodeScenes/DraggableCoal.tscn").instantiate()
	
	$"..".add_child(new_coal)
	new_coal.position = position
	new_coal_made.emit(new_coal)

func _on_mouse_entered():
	mouse_in = true

func _on_mouse_exited():
	mouse_in = false
