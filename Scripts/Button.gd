extends Button

@export var restartScene = false
@export var quitGame = false


#func _ready():
	
func _pressed():
	if(restartScene):
		get_tree().reload_current_scene()
	if(quitGame):
		get_tree().quit()
	print("Hello world!")
