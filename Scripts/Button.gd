extends Button

@export var restartScene = false
@export var quitGame = false
@export var returnToMenu = false

var menuScene = "res://NodeScenes/MainMenu.tscn"


#func _ready():
	
func _pressed():
	if(restartScene):
		get_tree().reload_current_scene()
	if(quitGame):
		get_tree().quit()
	if(returnToMenu):
		get_tree().change_scene_to_file(menuScene)
