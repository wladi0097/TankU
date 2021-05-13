extends Button

var index: int

func _ready():
	self.text = "Level " + String(self.index + 1)
	self.icon = load("res://ressources/mapImages/" + String(self.index) + ".png")


func _on_Control_button_up():
	get_tree().change_scene_to(Global.maps[self.index])
