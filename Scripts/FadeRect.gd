extends ColorRect

var fading = false

@export var FADE_SPEED: float = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not fading:
		return
	color.a = move_toward(color.a, 1, delta * FADE_SPEED)
	if color.a == 1:
		start_game()

func _on_story_board_animation_finished():
	fading = true

func start_game():
	get_tree().change_scene_to_file("res://NodeScenes/Main.tscn")
