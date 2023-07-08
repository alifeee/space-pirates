extends Area2D

@export var spinSpeed = 1
@onready var _animated_sprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	spinSpeed = spinSpeed * randf_range(0, 3) * randf_range(-1, 1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate(spinSpeed * delta)

func _on_body_entered(body):
	if(body.is_in_group("Player")):
		_animated_sprite.play("explode")
		body.kills_ship()

func _on_animated_sprite_2d_animation_finished():
	queue_free()
