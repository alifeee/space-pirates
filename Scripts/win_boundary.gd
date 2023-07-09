extends Area2D

@onready var anim = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("default")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	print("interaction")
	if(body.is_in_group("Player")):
		anim.play("used")
		body.ship_escaped()

func _on_animated_sprite_2d_animation_finished():
	anim.play("default")
