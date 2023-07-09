extends AnimatedSprite2D

@onready var buzz_sound = $"Buzz"

# Called when the node enters the scene tree for the first time.
func _ready():
	play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_switch_timer_timeout():
	animation = "spinnin"
	$"Timer".start()
	buzz_sound.play()


func _on_lightning_animation_finished():
	animation = "chillin"
	buzz_sound.stop()
