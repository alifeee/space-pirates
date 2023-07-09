extends AnimatedSprite2D

@export var Flash:Node2D
@export var FlashTimer:Timer

@onready var zap_sound = $"ZapSound"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	zap_sound.play()
	play()
	FlashTimer.start()
	Flash.visible = true


func _on_flash_timer_timeout():
	Flash.visible = false
