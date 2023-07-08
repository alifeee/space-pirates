extends Sprite2D

@export var controller: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	update_sprite()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_sprite():
	if controller == 0:
		self.texture = load("res://Assets/captain_hat.png")
	elif controller == 1:
		self.texture = load("res://Assets/mechanic_wrench.png")
	
func swap_controller():
	if controller == 0:
		controller = 1
	elif controller == 1:
		controller = 0
	update_sprite()
