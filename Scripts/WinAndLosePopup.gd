extends CanvasLayer

@export var IsWining = false
@export var MainLabel: Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func showSelf(didWin):
	visible = true
	if(didWin):
		MainLabel.text = "Congrats! You escaped from the Gem Keepers!"
	else:
		MainLabel.text = "You've encountered a terrible fate."
