extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("switch_player_control"):
		switch_players()

func switch_players():
	var ball0 = get_node("ControllableBall_p0")
	var ball1 = get_node("ControllableBall_p1")
	
	var ball0_player = ball0.PLAYER
	var ball1_player = ball1.PLAYER
	
	ball0.PLAYER = ball1_player
	ball1.PLAYER = ball0_player
	
